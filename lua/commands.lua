local M = {
  swift_build = function ()
    local luajob = require('luajob')
    local swift_build_job = luajob:new({ cmd = 'swift build', on_stdout = function(err, data)
    if err then
      print('error', err)
    elseif data then
      print('data', data)
    end
  end })
    swift_build_job.start()
  end
}

return M
