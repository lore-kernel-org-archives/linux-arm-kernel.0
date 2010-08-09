From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 9 Aug 2010 15:19:33 +0300
Subject: [PATCH 0/2] mxc_nand: fixes for purposed updates
In-Reply-To: <1281354805.26440.4.camel@localhost>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<cover.1281353601.git.baruch@tkos.co.il>
	<1281354805.26440.4.camel@localhost>
Message-ID: <20100809121933.GE2894@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Mon, Aug 09, 2010 at 12:53:25PM +0100, David Woodhouse wrote:
> On Mon, 2010-08-09 at 14:38 +0300, Baruch Siach wrote:
> > With these patches applied I've tested mxc-nand-pu on a i.MX25 based system.
> > 
> > Baruch Siach (2):
> >   mxc_nand: fix build error
> >   mxc_nand: remove unused variables
> > 
> >  drivers/mtd/nand/mxc_nand.c |    9 +++------
> >  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> These patches don't apply to the mtd-2.6.git tree.

These patches apply on top of the mxc-nand-pu branch of Sascha Hauer at 
git://git.pengutronix.de/git/imx/linux-2.6.git. Sorry for not mentioning this.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
