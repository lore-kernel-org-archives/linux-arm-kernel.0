From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 May 2013 15:53:23 +0100
Subject: [PATCH 0/5] Various DT fixes related to ux500 ASoC driver
In-Reply-To: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130530145323.GB1915@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Fabio Baltieri wrote:

> Hi Linus, Lee,
> 
> these are various fixes I found while testing the ux500 ASoC driver on HREF
> with device-tree.
> 
> First two patches are typos in DT files, while the others are
> specifically to support ux500 ASoC driver with DT enabled.
> 
> The last patch can go in the mfd tree, while the others may safely go
> through arm-soc, as there are no build dependencies or regression issues
> in general.
> 
> Thanks,
> Fabio
> 
> 
> Fabio Baltieri (5):
>   ARM: ux500: Fix trivial typo in v-anamic1 comment
>   ARM: ux500: Correct anamic2 typo in DT files
>   ARM: ux500: Add DT regulators for ab8500-codec
>   ARM: ux500: Provide auxdata to ux500 ASoC driver
>   mfd: ab8500-core: Add of_compatible property for ab8500-codec
> 
>  arch/arm/boot/dts/dbx5x0.dtsi     | 11 ++++++++---
>  arch/arm/boot/dts/href.dtsi       |  2 +-
>  arch/arm/boot/dts/hrefv60plus.dts |  2 +-
>  arch/arm/boot/dts/snowball.dts    |  2 +-
>  arch/arm/mach-ux500/cpu-db8500.c  |  2 ++
>  drivers/mfd/ab8500-core.c         |  1 +
>  drivers/regulator/ab8500.c        |  8 ++++----
>  7 files changed, 18 insertions(+), 10 deletions(-)

All look good to me.

For patches 1-4:

Acked-by: Lee Jones <lee.jones@linaro.org>

For patch 5:

Applied thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
