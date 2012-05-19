From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sat, 19 May 2012 17:25:56 +0200
Subject: [PATCH 00/18] DT enablement for Snowball
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120519152556.GP12015@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, May 17, 2012 at 02:45:05PM +0100, Lee Jones wrote:
> Hopefully the penultimate large patch-stack for Snowball
> enablement. After that only bits and bobs will remain.
> 
>  arch/arm/boot/dts/db8500.dtsi      |   92 +++++++++++++++-
>  arch/arm/boot/dts/snowball.dts     |    3 +
>  arch/arm/configs/u8500_defconfig   |    3 +
>  arch/arm/mach-ux500/Kconfig        |    1 +
>  arch/arm/mach-ux500/board-mop500.c |   55 +++-------
>  drivers/i2c/busses/i2c-nomadik.c   |   43 +++++++-
>  drivers/mfd/Makefile               |    5 +-
>  drivers/mfd/ab8500-core.c          |  176 ++++++++++++++++++++++++++-----
>  drivers/mfd/ab8500-debugfs.c       |    6 ++
>  drivers/mfd/ab8500-gpadc.c         |    8 +-
>  drivers/mfd/ab8500-i2c.c           |  160 ----------------------------
>  drivers/regulator/ab8500.c         |  204 +++++++++++++++++++++++++-----------
>  12 files changed, 457 insertions(+), 299 deletions(-)
All mfd patches (6, 8, 14, 15 and 17) applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
