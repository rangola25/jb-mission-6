import express from "express"
import cors from "cors"
import config from "config"
import fileUpload from "express-fileupload"
import sequelize from "./db/sequelize"
import errorLogger from "./middlewares/error/error-logger"
import { errorResponder } from "./middlewares/error/error-responder"
import notFound from "./middlewares/not-found"
import authRouter from "./routers/auth"
import adminRouter from "./routers/admin"
import userRouter from "./routers/vacations"
import followRouter from "./routers/follow"
import { createAppBucketIfNotExist } from "./aws/aws"

const app = express()

app.use(cors())
app.use(express.json())
app.use(fileUpload())

app.use("/auth", authRouter)
app.use("/vacations", userRouter)
app.use("/admin", adminRouter)
app.use("/likes", followRouter)

app.use(notFound)
app.use(errorLogger)
app.use(errorResponder)

const start = async () => {
  await sequelize.sync({ force: config.get("sequelize.sync.force") })
  await createAppBucketIfNotExist()
  app.listen(config.get("app.port"), () =>
    console.log(`${config.get("app.name")} started on port ${config.get("app.port")}...`)
  )
}

if (require.main === module) {
    start();
  }

export { app, start } 
