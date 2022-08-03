local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup ({
  css = { rgb_fn = true; };
  'javascript';
  html = {
    mode = 'foreground'
  }
}, { mode = 'foreground' })
