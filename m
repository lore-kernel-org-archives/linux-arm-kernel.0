From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:31:00 +0200
Subject: [PATCH v2 14/30] ARM: OMAP2+: omap4panda: Adapt to ehci-omap
 changes
In-Reply-To: <1359372631-8180-15-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-15-git-send-email-rogerq@ti.com>
Message-ID: <20130205093100.GW32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:15PM +0200, Roger Quadros wrote:
> Model RESET and Power for HS USB Port 1 as GPIO fixed regulators
> and link them to the 'nop-usb-xceiv' PHY by making them as "reset"
> and "vcc" supplies.
> 
> The RESET and Power will then be managed by the PHY driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/64790056/attachment.sig>
