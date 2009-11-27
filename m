From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Nov 2009 10:54:16 +0100
Subject: [alsa-devel] [PATCH V2] Add i.MX sound support
In-Reply-To: <eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
Message-ID: <20091127095416.GK27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 10:01:37AM +0100, javier Martin wrote:
> 2009/11/27 Sascha Hauer <s.hauer@pengutronix.de>
> 
> > Hi Javier,
> >
> > On Thu, Nov 26, 2009 at 04:53:21PM +0100, javier Martin wrote:
> > > Dear Sascha,
> > > what repository - branch are these patches tested against? They don't
> > seem
> > > to apply in git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> > > branch.
> >
> > Try this branch instead to get a full series also containing the mc13783
> > support and full board support for the Phytec boards:
> >
> > git://git.pengutronix.de/git/imx/linux-2.6.git asoc
> >
> > I posted only the patches relevant to the alsa list. By now mxc-master
> > should contain the missing bits.
> >
> 
> Sascha,
> it seems that git://git.pengutronix.de/git/imx/linux-2.6.git asoc is in an
> intermediate state since some files are already created (imx-ssi.*) and
> others aren't (imx-pcm-dma-mx2.c), this result in nasty errors when applying
> your last patches (v2).

The asoc branch I gave you already contains all relevant patches
including the ones I posted on this list. You don't need to apply anything
but your own board support on it. I just checked that it compiles and works.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
