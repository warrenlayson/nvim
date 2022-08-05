local status_ok, webdevicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

webdevicons.set_icon {
  lir_folder_icon = {
    icon = "",
    color = "#7ebae4",
    name = "LirFolderNode"
  }
}
