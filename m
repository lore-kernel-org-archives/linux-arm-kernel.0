From: balbi@ti.com (Felipe Balbi)
Date: Fri, 22 Jul 2011 11:53:57 +0300
Subject: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
	to_omap_device()
In-Reply-To: <1311292338-11830-2-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-2-git-send-email-khilman@ti.com>
Message-ID: <20110722085356.GH32058@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 04:52:11PM -0700, Kevin Hilman wrote:
> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
> 
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
> 

FWIW:

you can use either Reported-by: Felipe Balbi <balbi@ti.com> or
Reviewed-by: Felipe Balbi <balbi@ti.com>

thanks for posting the patch Kevin.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110722/51abee0b/attachment.sig>
