From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 9 Jul 2011 16:40:18 -0600 (MDT)
Subject: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
	to_omap_device()
In-Reply-To: <1309980377-5964-1-git-send-email-khilman@ti.com>
References: <1309980377-5964-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1107091639290.15984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Kevin Hilman wrote:

> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
> 
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, please consider this minor cleanup for the v3.1 merge window.
> Applies to v3.0-c6.
> 
>  arch/arm/plat-omap/omap_device.c |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)

Thanks, queued for 3.1 with Felipe's Reviewed-by at 
git://git.pwsan.com/linux-2.6 in 'omap_device_cleanup_3.1'.


- Paul
