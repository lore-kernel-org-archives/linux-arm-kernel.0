From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 May 2010 08:46:43 +0200
Subject: [PATCH 3/4] fec: add support for Freescale i.MX25 PDK (3DS)
In-Reply-To: <201005191715.52905.jcd@tribudubois.net>
References: <cover.1260785451.git.baruch@tkos.co.il>
	<20091216063402.GA13160@jasper.tkos.co.il>
	<20100125112116.GF6724@jasper.tkos.co.il>
	<201005191715.52905.jcd@tribudubois.net>
Message-ID: <20100520064642.GT31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 05:15:52PM +0200, Jean-Christophe Dubois wrote:
> le lundi 25 janvier 2010 Baruch Siach a ?crit
> > Hi Greg, netdev,
> > 
> > On Wed, Dec 16, 2009 at 08:34:06AM +0200, Baruch Siach wrote:
> > > On Wed, Dec 16, 2009 at 10:13:56AM +1000, Greg Ungerer wrote:
> > > > Baruch Siach wrote:
> > > > >On Tue, Dec 15, 2009 at 09:52:24PM +1000, Greg Ungerer wrote:
> > > > >>On 12/15/2009 06:31 PM, Baruch Siach wrote:
> > > > >>>+#ifndef CONFIG_M5272
> > > > >>
> > > > >>I would suggest making this conditional on FEC_MIIGSK_ENR.
> > > > >>Although the CONFIG_M5272 is the only case here currently,
> > > > >>that may change over the years. And using this here may not
> > > > >>be obvious to the causual code reader, since the register
> > > > >>offset definitions don't explicitly key on CONFIG_M5272.
> > > > >
> > > > >OK, I'll change this conditional.
> > > > >
> > > > >Can I take this as an Ack from you?
> > > > 
> > > > With that conditional check changed, sure:
> > > > 
> > > > Acked-by:  Greg Ungerer <gerg@uclinux.org>
> > > 
> > > Thanks. The updated patch below.
> > 
> > I'm really sorry to bug on this again, but since the platform code is
> > already upstream the i.MX25 code doesn't build without this patch
> > (include/linux/fec.h missing). So, someone please pick up this patch,
> > preferably prior to .33.
> > 
> > baruch
> 
> I am just wondering if somebody is going to pick up this patch 
> (http://patchwork.ozlabs.org/patch/41235/) so that it finds its way on 
> mainline.

I'm much in favour of this patch. David?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
