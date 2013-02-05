From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:27:26 +0200
Subject: [PATCH v2 11/30] usb: ehci-omap: Remove PHY reset handling code
In-Reply-To: <Pine.LNX.4.44L0.1301281233590.1997-100000@iolanthe.rowland.org>
References: <1359372631-8180-12-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301281233590.1997-100000@iolanthe.rowland.org>
Message-ID: <20130205092726.GT32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 12:34:16PM -0500, Alan Stern wrote:
> On Mon, 28 Jan 2013, Roger Quadros wrote:
> 
> > Reset GPIO handling for the PHY must be done in the PHY
> > driver. We use the PHY helpers instead to reset the PHY.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/cd5a5204/attachment.sig>
