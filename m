From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:28:07 +0200
Subject: [PATCH v2 13/30] ARM: OMAP2+: omap4panda: Provide USB Host's PHY
 platform data
In-Reply-To: <1359372631-8180-14-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-14-git-send-email-rogerq@ti.com>
Message-ID: <20130205092807.GV32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:14PM +0200, Roger Quadros wrote:
> Add platform device and data for 'nop-usb-xceiv'. This will be used
> as PHY for HS USB port 1, so provide binding information for it.
> 
> Get rid of managing the PHY clock as it will be done by the PHY driver.
> For that to work we create a clock alias that links the PHY clock name
> to the PHY device name.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/d298a77d/attachment.sig>
