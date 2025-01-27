import json
from pathlib import Path

home = str(Path.home())
with open(f'{home}/.cache/wal/colors.json', 'r') as file:
    colorjson = json.load(file)

colors = colorjson["colors"]

palette = {
   'color0': colors["color0"], 
   'color1': colors["color1"], 
   'color2': colors["color2"], 
   'color3': colors["color3"], 
   'color4': colors["color4"], 
   'color5': colors["color5"], 
   'color6': colors["color6"], 
   'color7': colors["color7"], 
   'color8': colors["color8"], 
   'color9': colors["color9"], 
   'color10': colors["color10"],
   'color11': colors["color11"],
   'color12': colors["color12"],
   'color13': colors["color13"],
   'color14': colors["color14"],
   'color15': colors["color15"],

   # 'color0': colorjson["background"],
   # 'color0': colorjson["background"],
   # 'color15': colorjson["cursor"],
   # 'color8': colorjson["background"],
   # 'color3': colorjson["separator"],
   # 'color3': colorjson["separator"],
   # 'color15': colorjson["cursor"],
   # 'color8': colorjson["comment"],
   # 'color15': "#ffffff",
   # 'color8': colorjson["comment"],
   # 'color13': colorjson["parens"],
   # 'color1': palette['color1'],
   # 'color3': colorjson["operator"],
   # 'color2': colorjson["variable"],
   # 'color4': colorjson["matched"],
   # 'color15': colorjson["cursor"],
   # 'color2': colorjson["variable"],
}


def color(c, options={}):
  #  spacing = options.get('spacing', {
  #      'vertical': 1,
  #      'horizontal': 1
  #  })

  #  padding = options.get('padding', {
  #      'top': spacing['vertical'],
  #      'right': spacing['horizontal'],
  #      'bottom': spacing['vertical'],
  #      'left': spacing['horizontal']
  #  })

    # Background color of the completion widget category headers.
    c.colors.completion.category.bg = palette['color0']

    # Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = palette['color8']

    # Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = palette['color8']

    # Foreground color of completion widget category headers.
    c.colors.completion.category.fg = palette['color15']

    # Background color of the completion widget for even rows.
    c.colors.completion.even.bg = palette['color0']

    # Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = palette['color0']

    # Text color of the completion widget.
    c.colors.completion.fg = palette['color15']

    # Background color of the selected completion item.
    c.colors.completion.item.selected.bg = palette['color3']

    # Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = palette['color3']

    # Top border color of the completion widget category headers.
    c.colors.completion.item.selected.border.top = palette['color3']

    # Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = palette['color15']

    # Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = palette['color3']

    # Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette['color0']

    # Color of the scrollbar handle in completion view.
    c.colors.completion.scrollbar.fg = palette['color15']

    # Background color for the download bar.
    c.colors.downloads.bar.bg = palette['color0']

    # Background color for downloads with errors.
    c.colors.downloads.error.bg = palette['color0']

    # Foreground color for downloads with errors.
    c.colors.downloads.error.fg = palette['color15']

    # Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = palette['color0']

    # Color gradient interpolation system for download backgrounds.
    ## Type: ColorSystem
    # Valid values:
    # - rgb: Interpolate in the RGB color system.
    # - hsv: Interpolate in the HSV color system.
    # - hsl: Interpolate in the HSL color system.
    # - none: Don't show a gradient.
    c.colors.downloads.system.bg = 'none'

    # Background color for hints. Note that you can use a `rgba(...)` value
    # for transparency.
    c.colors.hints.bg = palette['color0']

    # Font color for hints.
    c.colors.hints.fg = palette['color3']

    # Hints
    c.hints.border = '1px solid ' + palette['color0']

    # Font color for the matched part of hints.
    c.colors.hints.match.fg = palette['color8']

    # Background color of the keyhint widget.
    c.colors.keyhint.bg = palette['color0']

    # Text color for the keyhint widget.
    c.colors.keyhint.fg = palette['color4']

    # Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = palette['color3']

    # Background color of an error message.
    c.colors.messages.error.bg = palette['color0']

    # Border color of an error message.
    c.colors.messages.error.border = palette['color0']

    # Foreground color of an error message.
    c.colors.messages.error.fg = palette['color15']

    # Background color of an info message.
    c.colors.messages.info.bg = palette['color0']

    # Border color of an info message.
    c.colors.messages.info.border = palette['color0']

    # Foreground color an info message.
    c.colors.messages.info.fg = palette['color8']

    # Background color of a warning message.
    c.colors.messages.warning.bg = palette['color0']

    # Border color of a warning message.
    c.colors.messages.warning.border = palette['color0']

    # Foreground color a warning message.
    c.colors.messages.warning.fg = palette['color15']

    # Background color for prompts.
    c.colors.prompts.bg = palette['color0']

    # ## Border used around UI elements in prompts.
    c.colors.prompts.border = '1px solid ' + palette['color0']

    # Foreground color for prompts.
    c.colors.prompts.fg = palette['color13']

    # Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = palette['color3']

    # Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = palette['color0']

    # Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = palette['color3']

    # Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = palette['color0']

    # Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = palette['color3']

    # Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = palette['color0']

    # Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = palette['color2']

    # Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = palette['color0']

    # Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = palette['color8']

    # Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = palette['color15']

    # Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = palette['color15']

    # Background color of the statusbar.
    c.colors.statusbar.normal.bg = palette['color0']

    # Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = palette['color15']

    # Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = palette['color0']

    # Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = palette['color3']

    # Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = palette['color0']

    # Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = palette['color8']

    # Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette['color0']

    # Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette['color15']

    # Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette['color15']

    # Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette['color13']

    # Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.http.fg = palette['color1']

    # Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.https.fg = palette['color1']

    # Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette['color2']

    # Status bar padding
    #c.statusbar.padding = padding

    # Background color of the tab bar.
    ## Type: QtColor
    c.colors.tabs.bar.bg = palette['color0']

    # Color for the tab indicator on errors.
    ## Type: QtColor
    c.colors.tabs.indicator.error = palette['color15']

    # Color gradient start for the tab indicator.
    ## Type: QtColor
    c.colors.tabs.indicator.start = palette['color3']

    # Color gradient end for the tab indicator.
    ## Type: QtColor
    c.colors.tabs.indicator.stop = palette['color1']

    # Color gradient interpolation system for the tab indicator.
    ## Type: ColorSystem
    # Valid values:
    # - rgb: Interpolate in the RGB color system.
    # - hsv: Interpolate in the HSV color system.
    # - hsl: Interpolate in the HSL color system.
    # - none: Don't show a gradient.
    c.colors.tabs.indicator.system = 'none'

    # Background color of unselected odd tabs.
    ## Type: QtColor
    c.colors.tabs.odd.bg = palette['color0']

    # Foreground color of unselected odd tabs.
    ## Type: QtColor
    c.colors.tabs.odd.fg = palette['color6']

    c.colors.tabs.even.bg = palette['color0']

    # Foreground color of unselected even tabs.
    ## Type: QtColor
    c.colors.tabs.even.fg = palette['color6']

    # ## Background color of selected even tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.even.bg = palette['color8']

    # ## Foreground color of selected even tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.even.fg = palette['color15']

    # ## Background color of selected odd tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.odd.bg = palette['color8']

    # ## Foreground color of selected odd tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.odd.fg = palette['color15']

    # Tab padding
    #c.tabs.padding = padding
    c.tabs.indicator.width = 0
    #c.tabs.favicons.scale = 1


    c.colors.webpage.bg = palette['color0']
