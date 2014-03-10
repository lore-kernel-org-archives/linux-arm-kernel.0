From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 14:17:54 +0000
Subject: [PATCH v9 2/9] mfd: omap-usb-host: Always fail on clk_get() error
In-Reply-To: <1393510711-4697-3-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-3-git-send-email-rogerq@ti.com>
Message-ID: <20140310141754.GC15558@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Be more strict and always fail on clk_get() error.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 62 +++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 22 deletions(-)

I like to principle of the patch assuming that the devices would be
useless without their clocks.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
