From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 25 Aug 2015 12:10:33 -0700
Subject: [PULL] clk: at91: sama5d2 materials
In-Reply-To: <20150818102401.17de779b@bbrezillon>
References: <20150818102401.17de779b@bbrezillon>
Message-ID: <20150825191033.31346.67237@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-08-18 01:24:01)
> Stephen, Mike,
> 
> Here is a PR for the sama5d2 materials.
> I know we're already late in the release cycle and I'm not sure you can
> take this PR into account for 4.3, so if you can't could you please
> queue it for 4.4?

Queued for 4.4.

Thanks,
Mike

> 
> Thanks,
> 
> Boris
> 
> The following changes since commit c42743f11f58646a50bc4b96da363429dca0c5e6:
> 
>   clk: add bindings for the Ux500 clocks (2015-08-13 11:29:45 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/bbrezillon/linux-at91.git clk/atmel-clk-next
> 
> for you to fetch changes up to 3be0527c0f8bbbb744a6a34603d6a83e511c6741:
> 
>   clk: at91: add generated clock driver (2015-08-18 10:11:57 +0200)
> 
> ----------------------------------------------------------------
> Nicolas Ferre (4):
>       clk: at91: cleanup PMC header file for PCR register fields
>       clk: at91: modify PMC peripheral clock to deal with newer register layout
>       clk: at91: add PMC sama5d2 support
>       clk: at91: add generated clock driver
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt |  35 +++++++++++++++++++++
>  arch/arm/mach-at91/Kconfig                             |   3 ++
>  drivers/clk/at91/Makefile                              |   1 +
>  drivers/clk/at91/clk-generated.c                       | 306 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/at91/clk-peripheral.c                      |  24 +++++++++-----
>  drivers/clk/at91/pmc.c                                 |  21 +++++++++++++
>  drivers/clk/at91/pmc.h                                 |   3 ++
>  include/dt-bindings/clock/at91.h                       |   1 +
>  include/linux/clk/at91_pmc.h                           |  22 ++++++++-----
>  9 files changed, 400 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/clk/at91/clk-generated.c
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
