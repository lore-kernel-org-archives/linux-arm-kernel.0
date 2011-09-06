From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 13:05:16 -0700
Subject: [PATCH] ARM: platform_device: pdev_archdata: add omap_device
	pointer
In-Reply-To: <1312247692-13727-1-git-send-email-khilman@ti.com>
References: <1312247692-13727-1-git-send-email-khilman@ti.com>
Message-ID: <4E667CFC.2020300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 08/01/2011 06:14 PM, Kevin Hilman wrote:
> Add omap_device pointer to the ARM-specific arch data in the
> platform_device.  This will be used to attach OMAP-specific
> device-data to the platform device with device lifetime.
>
> Suggested-by: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Signed-off-by: Kevin Hilman<khilman@ti.com>

This patch has been accepted to the patch system as patch 7082/1

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7082/1

Kevin
