From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 11:09:03 +0000
Subject: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
In-Reply-To: <20110713095629.GE1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310528167-25035-1-git-send-email-b29396@freescale.com>
	<20110713091314.GC1928@pengutronix.de>
	<20110713095629.GE1928@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDB17@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, July 13, 2011 5:56 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; u.kleine-koenig at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
> 
> On Wed, Jul 13, 2011 at 11:13:14AM +0200, Wolfram Sang wrote:
> > On Wed, Jul 13, 2011 at 11:36:07AM +0800, Dong Aisheng wrote:
> > > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  arch/arm/mach-mxs/mach-mx28evk.c |   16 ++++++++++++++++
> > >  1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > Also needs in Kconfig:
> >
> > +       select MXS_HAVE_PLATFORM_MXS_I2C
> 
> #include <linux/i2c.h> for i2c_register_board_info() might be good, too...
Will add them all.
Thanks.

Regards
Dong Aisheng
