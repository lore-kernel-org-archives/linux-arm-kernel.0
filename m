From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 16:38:47 +0000
Subject: [PATCH v5 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <1394633237-16837-3-git-send-email-mporter@linaro.org>
References: <1394633237-16837-1-git-send-email-mporter@linaro.org>
 <1394633237-16837-3-git-send-email-mporter@linaro.org>
Message-ID: <20140312163847.GD22450@lee--X1>
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

Please don't sent patches that have already been accepted, as can get
pretty confusing.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
