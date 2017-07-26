From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Jul 2017 15:14:43 +0800
Subject: [linux-sunxi] [PATCH 05/10] clk: sunxi-ng: h3: gate then ungate
 PLL CPU clk after rate change
In-Reply-To: <20170723102749.17323-6-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-6-icenowy@aosc.io>
Message-ID: <CAGb2v66jK+iAbKVsv6=4tb0470KBdwU+AHjWDnWwKKTY+U+W6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> This patch utilizes the new PLL clk notifier to gate then ungate the
> PLL CPU clock after rate changes. This should prevent any system hangs
> resulting from cpufreq changes to the clk.
>
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Icenowy Zheng <icenowy@aosc.io>

This is missing

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")

ChenYu
