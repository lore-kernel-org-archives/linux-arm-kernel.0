From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Feb 2014 20:33:01 +0100
Subject: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
In-Reply-To: <20131218171301.GT4970@saruman.home>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <52B1D4C7.6030004@ti.com> <20131218170818.GR4970@saruman.home>
 <52B1D722.3040500@ti.com> <20131218171301.GT4970@saruman.home>
Message-ID: <20140213193301.GD17650@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 18, 2013 at 11:13:01AM -0600, Felipe Balbi wrote:
> On Wed, Dec 18, 2013 at 10:40:58PM +0530, Mugunthan V N wrote:
> > On Wednesday 18 December 2013 10:38 PM, Felipe Balbi wrote:
> > > On Wed, Dec 18, 2013 at 10:30:55PM +0530, Mugunthan V N wrote:
> > >> On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
> > >> Mac ID is to be filled by U-Boot and this kind of approach is already
> > >> rejected in linux-omap list.
> > >>
> > >> If proper ethaddr/eth*addr is populated in U-boot environment variable
> > >> then mac-address dt property in ethernet* device nodes will be populated
> > >> before boot kernel in U-boot. So I don't think this patch series is
> > >> required.
> > > but will u-boot read MACID from control module ?
> > >
> > Yes, U-Boot will read the MACID from control module and if a customer
> > wants to have his own MACID, U-boot ENV variable ethaddr/eth1addr must
> > be updated.
> 
> cool, then I agree this series shouldn't be applied ;-)
But even then I'd suggest to take at least patches 1 and 2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
