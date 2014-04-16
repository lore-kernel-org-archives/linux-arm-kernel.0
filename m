From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Apr 2014 16:43:50 +0100
Subject: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <1397209093-10077-2-git-send-email-carlo@caione.org>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-2-git-send-email-carlo@caione.org>
Message-ID: <20140416154350.GF19671@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
> 
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/axp20x.c       | 249 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 180 ++++++++++++++++++++++++++++++++
>  4 files changed, 442 insertions(+)
>  create mode 100644 drivers/mfd/axp20x.c
>  create mode 100644 include/linux/mfd/axp20x.h

This looks good to me know.

Once you have all the other Acks you need I'd be happy to create an
immutable branch for the other maintainers to pull from.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
