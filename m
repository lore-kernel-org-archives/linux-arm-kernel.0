From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Feb 2012 11:47:21 -0800
Subject: [PATCH] arm: omap: usb-host: fix compile warning
In-Reply-To: <1329209686-25551-1-git-send-email-balbi@ti.com>
References: <1329209686-25551-1-git-send-email-balbi@ti.com>
Message-ID: <20120214194721.GR1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120214 00:23]:
> when commit 3528c58 (OMAP: omap_device: when
> building return platform_device instead of
> omap_device) started returning a platform_device
> instead of a omap_device pointer when building
> a device, it failed to convert all users introducing
> a compile warning when building
> arch/arm/mach-omap2/usb-host.c.
> 
> This patch fixes that warning.

Thanks applying into fixes.

Tony
