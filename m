From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 11:10:56 +0800
Subject: [linux-sunxi] [PATCH 06/10] clk: sunxi-ng: allow set parent clock
 (PLL_CPUX) for CPUX clock on H3
In-Reply-To: <20170723102749.17323-7-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-7-icenowy@aosc.io>
Message-ID: <CAGb2v66bFjcB6CwNM+QDAqUxETqE6XX1UWKwqM_XAt6dOsjhLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The CPUX clock, which is the main clock of the ARM core on Allwinner H3,
> can be adjusted by changing the frequency of the PLL_CPUX clock.
>
> Allowing setting parent clock for the CPUX clock, thus the PLL_CPUX
> clock can be adjusted when adjusting the CPUX clock.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
