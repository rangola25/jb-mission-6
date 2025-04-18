// Assuming your error handler looks like this
import { Request, Response, NextFunction } from "express";
import AppError from "../../errors/app-error";

// Global error handler for Express
export const errorResponder = (
  err: AppError,  // Ensure this is typed as 'AppError'
  req: Request,
  res: Response,
  next: NextFunction
) => {
  // Using 'statusCode' instead of 'status'
  const status = err.statusCode || 500;  // Default to 500 if 'statusCode' is not set
  const message = err.message || "Internal Server Error";

  res.status(status).send(message);  // Corrected to use statusCode
};
