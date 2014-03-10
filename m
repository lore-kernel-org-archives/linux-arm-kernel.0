From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 14:34:43 +0000
Subject: [PATCH v9 4/9] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
In-Reply-To: <1393510711-4697-5-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-5-git-send-email-rogerq@ti.com>
Message-ID: <20140310143443.GE15558@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use a meaningful name for the reference clocks so that it indicates the function.
> 
> Update the OMAP4+ USB Host node as well to be in sync with the changes.
> 
> CC: Beno?t Cousson <bcousson@baylibre.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |  6 ++++++
>  arch/arm/boot/dts/omap5.dtsi |  6 ++++++
>  drivers/mfd/omap-usb-host.c  | 12 ++++++------
>  3 files changed, 18 insertions(+), 6 deletions(-)

The code looks fine and I queried the name change semantics before and
was satisfied with your answer, so as long as this patch has been
tested and nothing is broken:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
