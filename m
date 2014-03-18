From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Mar 2014 20:29:36 +0000
Subject: [PATCH 2/3] mfd: remove obsolete ti-ssp driver
In-Reply-To: <1395154561-1199121-3-git-send-email-arnd@arndb.de>
References: <1395154561-1199121-1-git-send-email-arnd@arndb.de>
 <1395154561-1199121-3-git-send-email-arnd@arndb.de>
Message-ID: <20140318202936.GV25478@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The tnetv107x platform is getting removed, so this driver
> is not needed any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig  |  11 --
>  drivers/mfd/Makefile |   1 -
>  drivers/mfd/ti-ssp.c | 465 ---------------------------------------------------
>  3 files changed, 477 deletions(-)
>  delete mode 100644 drivers/mfd/ti-ssp.c

Re-applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
