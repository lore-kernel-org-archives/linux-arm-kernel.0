From: balbi@ti.com (Felipe Balbi)
Date: Mon, 1 Jun 2015 13:34:47 -0500
Subject: [PATCH v4 0/2] Remaining sunxi musb patches
In-Reply-To: <79fc4306-a621-43b8-b347-e42a27beb134@googlegroups.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <79fc4306-a621-43b8-b347-e42a27beb134@googlegroups.com>
Message-ID: <20150601183447.GF26081@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 11:30:45AM -0700, Hans de Goede wrote:
> Hi,
> 
> On Sunday, May 31, 2015 at 6:10:32 PM UTC+2, Hans de Goede wrote:
> >
> > Hi Kishon & Felipe, 
> >
> > Here is an updated version of the remaining (not yet merged in Felipe's 
> > tree) 
> > sunxi musb patches. 
> >
> > The "phy-sun4i-usb: Add full support for usb0 phy / OTG" patch has been 
> > updated with a small bug-fix and is ready for merging. 
> >
> > The "musb: Add support for the Allwinner sunxi musb" patch has been 
> > updated 
> > to use the latest version of Maxime's sunxi sram controller driver. This 
> > one has a compile-time dependency on Maxime's sunxi sram controller 
> > driver, 
> > so it cannot be merged until that is merged. 
> >
> 
> 
> Arnd has just merged the updated sram controller into the next branch
> of the soc-drivers repo, so both these patches are now ready to merge.

all right, so for v4.3 merge window there will be no issues in queues
the two remaining patches. Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/29dfe505/attachment.sig>
