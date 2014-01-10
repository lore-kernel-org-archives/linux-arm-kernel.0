From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jan 2014 10:12:56 +0000
Subject: [PATCH v5 1/9] mfd: omap-usb-host: Use resource managed clk_get()
In-Reply-To: <1389269303-30465-2-git-send-email-rogerq@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-2-git-send-email-rogerq@ti.com>
Message-ID: <20140110101256.GG28141@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use devm_clk_get() instead of clk_get().
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 81 +++++++++------------------------------------
>  1 file changed, 16 insertions(+), 65 deletions(-)

Nice clean up.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
