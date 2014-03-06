From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Mar 2014 09:56:14 -0600
Subject: [PATCH v2 01/13] phy: rename struct omap_control_usb to struct
 omap_control_phy
In-Reply-To: <53189654.2090406@ti.com>
References: <1394116729-28811-1-git-send-email-rogerq@ti.com>
 <1394116729-28811-2-git-send-email-rogerq@ti.com>
 <53189654.2090406@ti.com>
Message-ID: <20140306155614.GD25648@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 09:07:56PM +0530, Kishon Vijay Abraham I wrote:
> Felipe,
> 
> On Thursday 06 March 2014 08:08 PM, Roger Quadros wrote:
> >From: Kishon Vijay Abraham I <kishon@ti.com>
> >
> >Rename struct omap_control_usb to struct omap_control_phy since it can
> >be used to control PHY of USB, SATA and PCIE. Also move the driver and
> >include files under *phy* and made the corresponding changes in the users
> >of phy-omap-control.
> >
> >Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >Signed-off-by: Roger Quadros <rogerq@ti.com>
> >---
> >  drivers/phy/Kconfig                                |  14 +-
> >  drivers/phy/Makefile                               |   1 +
> >  drivers/{usb => }/phy/phy-omap-control.c           | 165 +++++++++++----------
> >  drivers/phy/phy-omap-usb2.c                        |   8 +-
> >  drivers/phy/phy-ti-pipe3.c                         |   8 +-
> >  drivers/usb/musb/omap2430.c                        |   2 +-
> >  drivers/usb/phy/Kconfig                            |  10 --
> >  drivers/usb/phy/Makefile                           |   1 -
> 
> Hope you are fine with the changes in drivers/usb/? Can you give your
> Acked-by?

sure thing:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/745ad81c/attachment.sig>
