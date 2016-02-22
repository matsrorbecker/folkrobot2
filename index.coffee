fs =        require 'fs'
path =      require 'path'
express =   require 'express'

app = express()

app.use express.static path.join __dirname, 'public'

app.listen process.env.PORT or 3000