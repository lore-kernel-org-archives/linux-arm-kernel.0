From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Sep 2012 08:56:11 +0200
Subject: [PATCH 1/6] staging: drm/imx: Add i.MX drm core support
In-Reply-To: <20120912164929.GA24538@kroah.com>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-2-git-send-email-s.hauer@pengutronix.de>
 <20120912164929.GA24538@kroah.com>
Message-ID: <20120913065611.GB6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 09:49:29AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Sep 12, 2012 at 12:31:09PM +0200, Sascha Hauer wrote:
> > This patch adds the i.MX glue stuff between i.MX and drm.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/staging/Kconfig                |    2 +
> >  drivers/staging/Makefile               |    1 +
> 
> The patch fails at this point when applying it.
> 
> What tree did you make it against?  Please do so against linux-next or
> hopefully, the staging-next branch, and resubmit these.
> 
> Also, will this cause build errors if I don't have the needed patchs
> that are in the DRM tree in my tree?

Yes, the driver won't build without the patches. I'll rebase the IPU
support on linux-next once the dependency patches are in place.

Thanks
  Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
