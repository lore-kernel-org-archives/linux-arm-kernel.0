From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 15:06:57 -0600
Subject: [PATCH 2/3] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <5293BB6F.8070803@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-3-git-send-email-w-kwok2@ti.com>
 <20131125204232.GJ18046@saruman.home> <5293BB6F.8070803@ti.com>
Message-ID: <20131125210657.GQ18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 04:04:47PM -0500, Santosh Shilimkar wrote:
> On Monday 25 November 2013 03:42 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Nov 25, 2013 at 03:16:20PM -0500, WingMan Kwok wrote:
> >> Added device tree support for TI's Keystone USB driver and updated the
> >> Documentation with device tree binding information.
> >>
> >> On Keystone II platforms, we use no-op phy driver.
> >>
> >> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> >> ---
> 
> [...]
> 
> > BTW, some preliminary TRM coming my way would be cool, so I can better
> > understand how this HW behaves. A board would also go a long way, so I
> > could test this myself (we are part of the same company anyway).
> > 
> TRM documentation is bit different. There is no single TRM which has all
> the information but different chapters called user guides. For Keystone
> USB, the user guide isn't ready yet but there is an internal version for
> which we will send you a link. 
> 
> Boards are hard to get for now but we can see next year.

fair enough, documentation already helps a lot though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/8c245baf/attachment.sig>
