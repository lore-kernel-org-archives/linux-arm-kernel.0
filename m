From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Jul 2011 01:18:57 +0300
Subject: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
	to_omap_device()
In-Reply-To: <1309980377-5964-1-git-send-email-khilman@ti.com>
References: <1309980377-5964-1-git-send-email-khilman@ti.com>
Message-ID: <20110706221856.GB823@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 12:26:17PM -0700, Kevin Hilman wrote:
> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
> 
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
> 
> Cc: Felipe Balbi <balbi@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

thanks for sending this one Kevin ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110707/4dcf317b/attachment.sig>
