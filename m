From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:31:26 +0200
Subject: [PATCH 15/30] ARM: OMAP3: Beagle: Adapt to ehci-omap changes
In-Reply-To: <1359372631-8180-16-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-16-git-send-email-rogerq@ti.com>
Message-ID: <20130205093126.GX32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:16PM +0200, Roger Quadros wrote:
> Add platform device for 'nop-usb-xceiv'. This will be used as a
> PHY for HS USB Port 2, so provide binding information for it.
> 
> Model RESET and Power for HS USB Port 2 as GPIO fixed regulators
> and link them to the 'nop-usb-xceiv' PHY.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/77215d47/attachment.sig>
