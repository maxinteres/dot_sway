#!/usr/bin/sh

# 目标内置显示器名称（可按需修改）
INTERNAL="eDP-1"

# 获取所有已启用且不是内置显示器的输出，取第一个作为主外接显示器
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.active == true and .name != "'$INTERNAL'") | .name' | head -n1)

# 检查当前内置显示器是否开启
if swaymsg -t get_outputs | jq -e '.[] | select(.name == "'$INTERNAL'") | .active' | grep -q true; then
    # 内置开启 → 关闭它
    if [ -n "$EXTERNAL" ]; then
        # 将所有工作区移动到外接显示器
	for ws in $(swaymsg -t get_workspaces -r | jq -r '.[] | select(.representation != null) | .num'); do
	    swaymsg workspace number "$ws" >/dev/null
	    swaymsg move workspace to output "$EXTERNAL" >/dev/null
	done       
    fi
    swaymsg output "$INTERNAL" disable
else
    # 内置关闭 → 开启它
    swaymsg output "$INTERNAL" enable
fi
