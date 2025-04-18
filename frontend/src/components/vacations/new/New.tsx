import { useForm } from 'react-hook-form'
import './New.css'
import { useAppDispatch } from '../../../redux/hooks'
import useService from '../../../hooks/useService'
import { ChangeEvent, useState } from 'react'
import VacationDraft from '../../../models/vacation/Draft'
import Admin from '../../../services/auth-aware/admin'
import { newVacation } from '../../../redux/vacationSlice'
import { useNavigate } from 'react-router-dom'
import Draft from '../../../models/vacation/Draft'

export default function New(): JSX.Element {
    const { handleSubmit, register, formState, reset, setValue, trigger } = useForm<Draft>()

    const [previewImageSrc, setPreviewImageSrc] = useState<string>('')
    const [fileError, setFileError] = useState<boolean>(false)

    const dispatch = useAppDispatch()
    const adminService = useService(Admin)
    const navigate = useNavigate()

    function resetTime(date: Date): Date {
        const resetDate = new Date(date);
        resetDate.setHours(0, 0, 0, 0);
        return resetDate;
    }

    async function submit(draft: VacationDraft) {
        try {
            const startDate = new Date(draft.startDate)
            const endDate = new Date(draft.endDate)
            const today = resetTime(new Date());
            const file = draft.file

            if (endDate <= startDate) {
                alert("The finish date must be later than the starting date")
                return
            }

            if (startDate <= today) {
                alert("The start date can not be in the past. pay attention!")
                return
            }

            if (!file) {
                setFileError(true)
                return
            }
            
            const newVacationFromServer = await adminService.createVacation(draft)
            reset()
            setPreviewImageSrc('')
            setFileError(false)
            dispatch(newVacation(newVacationFromServer))
            navigate('/admin/vacations')
            window.location.reload()
        } catch (e) {
            alert(e)
        }
    }

    function cancel(){
        navigate(`/admin/vacations`)
    }

    function previewImage(event: ChangeEvent<HTMLInputElement>) {
        const file = event.currentTarget.files && event.currentTarget.files[0]
        if (file) {
            setFileError(false)
            const imageSource = URL.createObjectURL(file)
            setPreviewImageSrc(imageSource)
            setValue('file', file)  
        }
    }

    // Combined approach for form submission
    async function onFormSubmit(e: React.FormEvent) {
        e.preventDefault()

        // First, trigger validation for all fields
        const isFormValid = await trigger()
        
        // Check file separately
        const fileInput = document.querySelector('input[type="file"]') as HTMLInputElement
        const fileExists = fileInput.files && fileInput.files.length > 0
        
        if (!fileExists) {
            setFileError(true)
        } else {
            setFileError(false)
        }
        
        // Only proceed if form is valid AND file exists
        if (isFormValid && fileExists) {
            handleSubmit(submit)(e)
        }
    }

    return (
        <div className='NewVacationContainer'>
            <div className='NewVacation'>
                <form onSubmit={onFormSubmit}>
                    <label>destination</label>
                    <input {...register('destination', {
                        required: {
                            value: true,
                            message: 'You must provide a destination'
                        }
                    })} />
                    <span className='error'>{formState.errors.destination?.message}</span>

                    <label>description</label>
                    <textarea {...register('description', {
                        required: {
                            value: true,
                            message: 'You must provide a description'
                        },
                        minLength: {
                            value: 10,
                            message: 'Description must be 10 chars long'
                        }
                    })} />
                    <span className='error'>{formState.errors.description?.message}</span>

                    <label>start on</label>
                    <input type='date' {...register('startDate', {
                        required: {
                            value: true,
                            message: 'You must provide a start date'
                        }
                    })} />
                    <span className='error'>{formState.errors.startDate?.message}</span>

                    <label>end on</label>
                    <input type='date' {...register('endDate', {
                        required: {
                            value: true,
                            message: 'You must provide a end date'
                        }
                    })} />
                    <span className='error'>{formState.errors.endDate?.message}</span>

                    <label>price</label>
                    <div className="inputWithSymbol">
                        <span className="dollarSymbol">$</span>
                        <input type='number' {...register('price', {
                            required: {
                                value: true,
                                message: 'You must provide the price'
                            },
                            min: {
                                value: 0,
                                message: 'Price can not be negative.'
                            },
                            max: {
                                value: 10000,
                                message: 'Price can not be higher than 10000$'
                            }
                        })} />
                    </div>
                    <span className='error'>{formState.errors.price?.message}</span>

                    <label>cover Image</label>
                    <input type='file' onChange={previewImage} />
                    <img src={previewImageSrc} alt="Preview" style={{ width: '200px', height: 'auto' }} />
                    {fileError && <span className='error'>You must provide an image</span>}

                    <button className='submit' type="submit">Add Vacation</button>
                    <button type="button" onClick={cancel} className="cancel" >Cancel</button>
                </form>
            </div>
        </div>
    )
}