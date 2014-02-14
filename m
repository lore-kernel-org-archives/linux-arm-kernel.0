From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Feb 2014 09:57:13 +0000
Subject: [PATCH v7 01/12] mfd: omap-usb-host: Use resource managed
 clk_get()
In-Reply-To: <1392200333-28397-2-git-send-email-rogerq@ti.com>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
 <1392200333-28397-2-git-send-email-rogerq@ti.com>
Message-ID: <20140214095713.GB7380@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use devm_clk_get() instead of clk_get().
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/omap-usb-host.c | 81 +++++++++------------------------------------
>  1 file changed, 16 insertions(+), 65 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
