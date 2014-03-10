From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 14:32:07 +0000
Subject: [PATCH v9 3/9] mfd: omap-usb-host: Use proper clock name instead
 of alias
In-Reply-To: <1393510711-4697-4-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-4-git-send-email-rogerq@ti.com>
Message-ID: <20140310143207.GD15558@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use the proper clock name 'usbhost_120m_fck' instead of the
> alias 'ehci_logic_fck'
> 
> Get rid of the 'ehci_logic_fck' alias from the OMAP3 hwmod data
> as well.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 6 ------
>  drivers/mfd/omap-usb-host.c                | 5 +++--
>  2 files changed, 3 insertions(+), 8 deletions(-)

So long as the platform guys are okay with the semantic change, the
MFD diff looks okay to me. For the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
