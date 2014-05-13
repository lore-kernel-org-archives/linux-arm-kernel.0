From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 May 2014 19:12:16 -0700
Subject: [GIT PULL] clk: socfpga: Clock updates for v3.16
In-Reply-To: <1399915981-5403-1-git-send-email-dinguyen@altera.com>
References: <1399915981-5403-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140513021216.5943.87439@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting dinguyen at altera.com (2014-05-12 10:33:01)
> Hi Mike,
> 
> Please consider pulling this patch in for v3.16.

Pulled.

Thanks,
Mike

> 
> Thanks,
> Dinh
> 
> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> 
>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-update-for-v3.16
> 
> for you to fetch changes up to 0691bb1b5a1865b3bbc9b7ce6e26eff546abb1cf:
> 
>   clk: socfpga: add divider registers to the main pll outputs (2014-05-12 12:27:22 -0500)
> 
> ----------------------------------------------------------------
> Adds support getting the divider registers for the MAIN PLL that was once
> thought to be hidden.
> 
> ----------------------------------------------------------------
> Dinh Nguyen (1):
>       clk: socfpga: add divider registers to the main pll outputs
> 
>  drivers/clk/socfpga/clk-gate.c   |    1 -
>  drivers/clk/socfpga/clk-periph.c |   22 +++++++++++++++++++---
>  drivers/clk/socfpga/clk.h        |    4 ++++
>  3 files changed, 23 insertions(+), 4 deletions(-)
