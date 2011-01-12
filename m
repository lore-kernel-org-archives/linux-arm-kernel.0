From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 08:42:25 +0100
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <4D2C5A55.7050502@snapgear.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
	<20110111102717.GG26617@pengutronix.de>
	<4D2C4BEC.1030003@snapgear.com>
	<20110111130749.GQ24920@pengutronix.de>
	<4D2C5A55.7050502@snapgear.com>
Message-ID: <20110112074225.GY24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, Jan 11, 2011 at 11:25:41PM +1000, Greg Ungerer wrote:
> On 11/01/11 23:07, Uwe Kleine-K?nig wrote:
> >On Tue, Jan 11, 2011 at 10:24:12PM +1000, Greg Ungerer wrote:
> >>On 11/01/11 20:27, Sascha Hauer wrote:
> >>>On Thu, Jan 06, 2011 at 03:13:13PM +0800, Shawn Guo wrote:
> >>>This option is used nowhere and should be removed. Certainly it does not
> >>>have the effect of enabling the second ethernet controller.
> >>
> >>It does for a ColdFire platform...
> >>
> >>grep -r CONFIG_FEC2 *
> >>
> >>arch/m68knommu/configs/m5275evb_defconfig:CONFIG_FEC2=y
> >>arch/m68knommu/platform/527x/config.c:#ifdef CONFIG_FEC2
> >>arch/m68knommu/platform/527x/config.c:#ifdef CONFIG_FEC2
> >IMHO Sascha's comment[1] applies here, too.
> 
> I am not arguing that it doesn't :-)
> 
> Simply that removing that config option and doing nothing
> else would not be the right thing to do.
> 
> Regards
> Greg
> 
> 
> >And someone might want to do what he suggested soon or the patch
> >removing CONFIG_FEC2[2] needs to be commented accordingly.
note that davem took the patch removing CONFIG_FEC2 now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
