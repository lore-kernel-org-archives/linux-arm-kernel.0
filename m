From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 09:46:21 +0000
Subject: [PATCH v4 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <1394580837-8331-3-git-send-email-mporter@linaro.org>
References: <1394580837-8331-1-git-send-email-mporter@linaro.org>
 <1394580837-8331-3-git-send-email-mporter@linaro.org>
Message-ID: <20140312094621.GH5672@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add a driver for the BCM590xx PMU multi-function devices. The driver
> initially supports regmap initialization and instantiation of the
> voltage regulator device function of the PMU.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  drivers/mfd/Kconfig          |  8 ++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/bcm590xx.c       | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/bcm590xx.h | 31 +++++++++++++++
>  4 files changed, 133 insertions(+)
>  create mode 100644 drivers/mfd/bcm590xx.c
>  create mode 100644 include/linux/mfd/bcm590xx.h

Ah, you fixed the nit.

Applied this one instead then.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
