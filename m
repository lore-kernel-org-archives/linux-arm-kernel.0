From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 08:56:22 +0900
Subject: [PATCH 5/7] gpio/samsung: Added gpio-samsung.c to support Samsung
	GPIOs
In-Reply-To: <20110920234941.GV7781@ponder.secretlab.ca>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
	<1314707249-12241-6-git-send-email-kgene.kim@samsung.com>
	<20110920234941.GV7781@ponder.secretlab.ca>
Message-ID: <003c01cc77f0$e63c9c50$b2b5d4f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:

> 
> On Tue, Aug 30, 2011 at 09:27:27PM +0900, Kukjin Kim wrote:
> > This patch adds support for Samsung GPIOs with one gpio driver.
> > Actually there are drivers/gpio-s3c24xx.c, gpio-s3c64xx.c,
> > gpio-s5p64x0.c, gpio-s5pc100.c, gpio-s5pv210.c, gpio-exynos4.c,
> > gpio-plat-samsung.c, plat-samsung/gpio-config.c and gpio.c to
> > support each Samsung SoCs before.
> > Basically, the gpio-samsung.c has been made by their merging
> > and removing duplicated definitions.
> >
> > Note: gpio-samsung.c includes some SoC dependent codes and it
> > will be replaced next time.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/gpio/Makefile       |    1 +
> >  drivers/gpio/gpio-samsung.c | 2686
> +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 2687 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/gpio/gpio-samsung.c
> 
> It's a big driver file, but I'll go ahead and pick this up without too
> much review because at least it is all in the same place now.  I'll
> expect further cleanup in future patches.
> 
Yes, as you said, I agree this is needed some cleanup. I and my team will do
it next time.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
