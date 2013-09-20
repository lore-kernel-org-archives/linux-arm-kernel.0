From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 10:44:06 -0500
Subject: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
In-Reply-To: <1376561909-4406-4-git-send-email-rogerq@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
Message-ID: <20130920154406.GV26101@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> The platform data bits can be inferred from the other members of
> struct usbhs_phy_data. So get rid of the platform_data member.
> 
> Build the platform data for the PHY device in usbhs_init_phys() instead.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
patches in this series ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/5c0baadd/attachment.sig>
