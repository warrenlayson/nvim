local status_ok, distant = pcall(require, "distant")
if not status_ok then
  return
end

local status_ok_1, settings = pcall(require, "distant.settings")
if not status_ok_1 then
  return
end

distant.setup {
  ['*'] = settings.chip_default()
}
