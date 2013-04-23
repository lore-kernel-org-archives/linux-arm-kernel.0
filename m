From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Apr 2013 18:15:33 +0300
Subject: [PATCH 06/10] usb: musb: ux500: add device tree probing support
In-Reply-To: <201304231714.06326.arnd@arndb.de>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-7-git-send-email-lee.jones@linaro.org>
 <201304231714.06326.arnd@arndb.de>
Message-ID: <20130423151533.GD15177@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 05:14:06PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 April 2013, Lee Jones wrote:
> > +Required properties:
> > + - compatible : Should be "stericsson,db8500-musb"
> > + - reg        : Offset and length of registers
> > + - interrupts : Interrupt; mode, number and trigger
> > + - mode       : One of; "host", "otg", or "peripheral"
> 
> I think we don't have any precedent for this combination of "mode" property
> and contents. You could either try to match ehci-omap.txt and do

there is dr_mode which other folks are using. Let's use the same thing.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/22540e2b/attachment.sig>
