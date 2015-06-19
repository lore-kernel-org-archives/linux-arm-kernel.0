From: mturquette@linaro.org (Michael Turquette)
Date: Fri, 19 Jun 2015 09:28:19 -0700
Subject: [PULL] clk: at91: fixes for 4.1
In-Reply-To: <20150619155246.18af1068@bbrezillon>
References: <20150619155246.18af1068@bbrezillon>
Message-ID: <20150619162819.9112.53363@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-06-19 06:52:46)
> Hi Mike,
> 
> As you suggested, here is a PR including several fixes for the at91 clk
> drivers. BTW, thanks for accepting to take this PR so late in the release
> cycle.
> 
> Best Regards,
> 
> Boris
> 
> The following changes since commit 03bc10ab5b0f9b8f81bffbe6e40c944f9d3dbcc5:
> 
>   clk: check ->determine/round_rate() return value in clk_calc_new_rates (2015-04-12 21:09:49 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/bbrezillon/linux-at91.git ccf/atmel-fixes-for-4.1
> 
> for you to fetch changes up to 28df9c2fb6f896179fcffd5a3f5a86e2d1dff0a5:
> 
>   clk: at91: fix h32mx prototype inclusion in pmc header (2015-06-19 15:48:34 +0200)

Pulled.

Thanks,
Mike

> 
> ----------------------------------------------------------------
> Boris Brezillon (2):
>       clk: at91: pll: fix input range validity check
>       clk: at91: fix PERIPHERAL_MAX_SHIFT definition
> 
> Nicolas Ferre (2):
>       clk: at91: trivial: typo in peripheral clock description
>       clk: at91: fix h32mx prototype inclusion in pmc header
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt |  2 +-
>  drivers/clk/at91/clk-peripheral.c                      |  8 ++++----
>  drivers/clk/at91/clk-pll.c                             | 12 ++++++++++--
>  drivers/clk/at91/pmc.h                                 |  2 +-
>  4 files changed, 16 insertions(+), 8 deletions(-)
> 
> 
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
