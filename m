From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Feb 2015 09:56:45 +0000
Subject: [PATCH 13/13] mfd: Add support for the MediaTek MT6397 PMIC
In-Reply-To: <1423478845-2835-14-git-send-email-s.hauer@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-14-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150216095645.GA2037@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Flora Fu <flora.fu@mediatek.com>
> 
> This adds support for the MediaTek MT6397 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Regulator
> - RTC
> - Audio codec
> - GPIO
> - Clock
> 
> It is interfaced to the host controller using SPI interface by a proprietary
> hardware called PMIC wrapper or pwrap. MT6397 MFD is a child device of the
> pwrap.
> 
> Signed-off-by: Flora Fu, MediaTek
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig                  |  10 +
>  drivers/mfd/Makefile                 |   1 +
>  drivers/mfd/mt6397-core.c            | 223 +++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |  64 +++++++
>  include/linux/mfd/mt6397/registers.h | 362 +++++++++++++++++++++++++++++++++++
>  5 files changed, 660 insertions(+)
>  create mode 100644 drivers/mfd/mt6397-core.c
>  create mode 100644 include/linux/mfd/mt6397/core.h
>  create mode 100644 include/linux/mfd/mt6397/registers.h

Looks okay to me now.

Acked-by: Lee Jones <lee.jones@linaro.org>

What's the merge plan for this set?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
