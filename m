From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Nov 2012 09:51:01 +0100
Subject: [PATCH 18/24] MAINTAINERS: remove drivers/mmc/host/imxmmc.*
In-Reply-To: <201211240918.42930.ppisa@pikron.com>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
 <1353716808-16375-19-git-send-email-cesarb@cesarb.net>
 <201211240918.42930.ppisa@pikron.com>
Message-ID: <20121126085101.GZ10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Sat, Nov 24, 2012 at 09:18:42AM +0100, Pavel Pisa wrote:
> On Saturday 24 November 2012 01:26:42 Cesar Eduardo Barros wrote:
> > This driver was removed by commit 6187fee (mmc: remove imxmmc driver).
> >
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pavel Pisa <ppisa@pikron.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
> > ---
> >  MAINTAINERS | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fc646ef..cac8e49 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4905,12 +4905,6 @@ F:	Documentation/video4linux/meye.txt
> >  F:	drivers/media/pci/meye/
> >  F:	include/uapi/linux/meye.h
> >
> > -MOTOROLA IMX MMC/SD HOST CONTROLLER INTERFACE DRIVER
> > -M:	Pavel Pisa <ppisa@pikron.com>
> > -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > -S:	Maintained
> > -F:	drivers/mmc/host/imxmmc.*
> > -
> >  MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
> >  M:	Jiri Slaby <jirislaby@gmail.com>
> >  S:	Maintained
> 
> Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> I have still the hardware but have lack resources to keep with current
> kernel development for that old HW. We plan to switch to newer i.MX
> hardware - hopefully with more bug free MMC/SD support, because MX1
> has taken me yer a year of fighting with its bugs (on Linux and RTEMS
> as well).

They are bug free enough to work ;)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
