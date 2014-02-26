From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Feb 2014 12:51:57 +0000
Subject: [PATCH 4/5] mfd: remove obsolete ti-ssp driver
In-Reply-To: <1393418614-3968549-5-git-send-email-arnd@arndb.de>
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
 <1393418614-3968549-5-git-send-email-arnd@arndb.de>
Message-ID: <20140226125157.GM9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The tnetv107x platform is getting removed, so this driver
> is not needed any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig  |  11 --
>  drivers/mfd/Makefile |   1 -
>  drivers/mfd/ti-ssp.c | 465 ---------------------------------------------------
>  3 files changed, 477 deletions(-)
>  delete mode 100644 drivers/mfd/ti-ssp.c

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
