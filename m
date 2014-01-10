From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jan 2014 10:11:07 +0000
Subject: [PATCH v5 3/9] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <1389269303-30465-4-git-send-email-rogerq@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-4-git-send-email-rogerq@ti.com>
Message-ID: <20140110101107.GF28141@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Jan 2014, Roger Quadros wrote:

> The omap-usb-host driver expects certained named clocks.
> Add this information to the DT binding document.
> 
> Use clock names as per function for reference clocks.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/mfd/omap-usb-host.txt      | 23 ++++++++++++++++++++++
>  drivers/mfd/omap-usb-host.c                        |  6 +++---
>  2 files changed, 26 insertions(+), 3 deletions(-)

Please don't mix up binding changes with code ones.

Separate patch please.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
