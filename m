From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Feb 2014 10:53:27 +0000
Subject: [PATCH v2 05/15] mfd: max14577: Add detection of device type
In-Reply-To: <1391767487-10017-6-git-send-email-k.kozlowski@samsung.com>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140207105327.GK14727@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch continues the preparation for adding support for max77836
> device to existing max14577 driver.
> 
> Add enum for types of devices supported by this driver. The device type
> will be detected by matching of_device_id, or i2c_device_id as a
> fallback.
> 
> The patch also moves to separate function the code related to displaying
> DeviceID register values.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/max14577.c               |   64 ++++++++++++++++++++++++----------
>  include/linux/mfd/max14577-private.h |   12 ++++---
>  2 files changed, 53 insertions(+), 23 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
