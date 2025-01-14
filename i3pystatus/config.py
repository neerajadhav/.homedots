from i3pystatus import Status

status = Status()

status.register(
    'battery',
    interval=5,
    format='[{status}] {percentage:.2f}% ({remaining:%E%hh:%Mm}) /',
    alert=True,
    alert_percentage=20,
    critical_level_percentage=5,
    critical_level_command="notify-send '󰂃 Critical Battery Level!'",
    alert_format_title='Low Battery Warning',
    alert_format_body='Battery {battery_ident} is at {percentage:.2f}% ({remaining:%E%hh:%Mm})',
    status={
        'DPL': 'DPL',
        'CHR': 'AC',
        'DIS': 'DC',
        'FULL': 'Full',
    },
    full_color="#00ff00",
    charging_color="#00ff00",
    critical_color="#ff0000",
    use_design_percentage=True,
    levels={
        10: "󰁺",
        20: "󰁻",
        30: "󰁼",
        40: "󰁽",
        50: "󰁾",
        60: "󰁿",
        70: "󰂀",
        80: "󰂁",
        90: "󰂂",
        
    }
)

status.register("clock",
    format=" %a %b %-d %y /  %I:%M:%S %p",)

status.register("temp",
    format=" {temp:.0f}°C",)

status.register("disk",
    path="/",
    format=" {avail} ({percentage_free}%)",)

status.register("pulseaudio",
    format=" {volume}",
    step=10)

status.register(
    "network",
    interface="enp2s0",  # Ethernet interface
    format_up="󰈀 {v4} (󰁅 {bytes_recv}KB/s 󰁝 {bytes_sent}KB/s)",
    format_down="󰈀 No Lan",
    dynamic_color=True,
    start_color="#00FF00",  # Green for low traffic
    end_color="#FF0000",  # Red for high traffic
    recv_limit=2048,  # Maximum expected receive traffic in KiB/s
    sent_limit=1024,  # Maximum expected send traffic in KiB/s
    divisor=1024,  # Convert bytes to KiB
    color_up="#00FF00",  # Default up color
    color_down="#FFA500",  # Default down color
    on_leftclick="nm-connection-editor",  # Open network manager on left-click
)

status.register(
    "network",
    interface="wlp3s0",  # Wi-Fi interface
    format_up="󰖩 {essid} {quality}% (󰁅 {bytes_recv}KB/s 󰁝 {bytes_sent}KB/s)",
    format_down="󱚼 No Wifi",
    dynamic_color=True,
    start_color="#00FF00",  # Green for good signal
    end_color="#FF0000",  # Red for poor signal or high traffic
    recv_limit=1024,  # Maximum expected receive traffic in KiB/s
    sent_limit=512,  # Maximum expected send traffic in KiB/s
    divisor=1024,  # Convert bytes to KiB
    color_up="#00FF00",  # Default up color
    color_down="#FFA500",  # Default down color
    on_leftclick="nm-connection-editor",  # Open network manager on left-click
)

status.run()