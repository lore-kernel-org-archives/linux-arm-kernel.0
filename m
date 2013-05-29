From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 14:48:13 -0700
Subject: [PATCH 0/2] clk: vt8500: updates for 3.11
In-Reply-To: <1368433260-16073-1-git-send-email-linux@prisktech.co.nz>
References: <1368433260-16073-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130529214813.6058.81599@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Prisk (2013-05-13 01:20:58)
> Hi Mike,
> 
> Two updates for the arch-vt8500 clock code:
> 
> #1: Add support for the WM8850 PLL.
> #2: Remove a second divisor check in vt8500_dclk_set_rate() which causes the
> divisor to be round-down too low.
> 

Taken both into clk-next.

Thanks,
Mike

> Regards
> Tony Prisk
> 
> Tony Prisk (2):
>   clk: vt8500: Add support for clocks on the WM8850 SoCs
>   clk: vt8500: Remove unnecessary divisor adjustment in
>     vtwm_dclk_set_rate()
> 
>  Documentation/devicetree/bindings/clock/vt8500.txt |    2 +
>  drivers/clk/clk-vt8500.c                           |   75 ++++++++++++++++++--
>  2 files changed, 73 insertions(+), 4 deletions(-)
> 
> -- 
> 1.7.9.5
