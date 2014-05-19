From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 18:28:17 +0100
Subject: [RFC PATCH 1/3] mfd: AXP22x: add support for APX221 PMIC
In-Reply-To: <1400176305-22737-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1400176305-22737-1-git-send-email-boris.brezillon@free-electrons.com>
 <1400176305-22737-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140519172817.GE20435@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch introduces preliminary support for the X-Powers AXP221 PMIC.
> The AXP221 is typically used on boards using Allwinner's A31 SoC.
> 
> At the moment, this driver only exposes regulator devices, but other
> subdevices.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/axp22x.c       | 237 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp22x.h | 149 ++++++++++++++++++++++++++++
>  4 files changed, 399 insertions(+)
>  create mode 100644 drivers/mfd/axp22x.c
>  create mode 100644 include/linux/mfd/axp22x.h

Not a chance.

Farrrr, too much common code with axp20x.c - please merge into one file.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
