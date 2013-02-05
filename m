From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:31:53 +0200
Subject: [PATCH 17/30] ARM: OMAP3: 3630SDP: Adapt to ehci-omap changes
In-Reply-To: <1359372631-8180-18-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-18-git-send-email-rogerq@ti.com>
Message-ID: <20130205093153.GZ32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:18PM +0200, Roger Quadros wrote:
> Add 2 platform devices for 'nop-usb-xceiv'. These will be used
> as PHYs for HS USB ports 1 and 2 so provide binding information
> for them.
> 
> Model RESET for HS USB Ports 1 and 2 as GPIO fixed regulators and
> link them to the 2 PHYs we just created.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/9fec4201/attachment.sig>
