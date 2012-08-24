From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 12:07:33 -0700
Subject: [PATCH v3 03/23] serial: omap: don't access the platform_device
In-Reply-To: <1345717983-18179-4-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-4-git-send-email-balbi@ti.com>
Message-ID: <20120824190733.GQ11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120823 03:37]:
> The driver doesn't need to know about its platform_device.
> 
> Everything the driver needs can be done through the
> struct device pointer. In case we need to use the
> OMAP-specific PM function pointers, those can make
> sure to find the device's platform_device pointer
> so they can find the struct omap_device through
> pdev->archdata field.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
