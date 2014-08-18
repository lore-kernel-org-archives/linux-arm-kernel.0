From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Aug 2014 08:58:40 +0200
Subject: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <20140816164647.GA2858@katana>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <20140816164647.GA2858@katana>
Message-ID: <20140818065840.GA12930@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 16, 2014 at 11:46:48AM -0500, Wolfram Sang wrote:
> 
> > diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> > index 9cfaab8152be..5a31c2b322ee 100644
> > --- a/drivers/net/ethernet/ti/Makefile
> > +++ b/drivers/net/ethernet/ti/Makefile
> > @@ -8,5 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
> >  obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
> >  obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
> >  obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
> > +obj-$(CONFIG_TI_CPSW_CTRL_MACID) += cpsw-ctrl-macid.o
> >  obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> >  ti_cpsw-y := cpsw_ale.o cpsw.o cpts.o
> 
> Leftover from your last series?

Yes thanks, will remove it for the next version.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/0fcc2d8b/attachment.sig>
