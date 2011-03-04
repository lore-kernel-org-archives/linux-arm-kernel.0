From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Mar 2011 10:33:53 +0900
Subject: [PATCH 0/7] Various Samsung updates
In-Reply-To: <20110303145910.GC17460@trinity.fluff.org>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
	<20110303145910.GC17460@trinity.fluff.org>
Message-ID: <022301cbda0c$3c550a60$b4ff1f20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
> On Thu, Mar 03, 2011 at 02:57:11PM +0000, Mark Brown wrote:
> > This is a patch series I've got built up for the Samsung platforms, some
> > of which has been pending for the entire release cycle.  I know Ben's
> > said he's extremely busy right now (as you can see some of these patches
> > are from him), perhaps it would make sense to apply these via Kukjin's
> > tree for the time being?
> 
> I'm ok with these being sent upstream via whoever's tree. I do note
> that there's a pile of s3c24xx I seem to have missed completely after
> falling off linux-kernel a couple of months ago.
> 
Ok, applied into my tree :)

As a note, they will be sent to upstream this weekend for 38.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> > Ben Dooks (2):
> >       ARM: S3C64XX: Add clock for i2c1
> >       ARM: S3C64XX: Reduce output of s3c64xx_dma_init1()
> >
> > Mark Brown (5):
> >       ARM: SAMSUNG: Include devs.h in dev-uart.c to prototype devices
> >       ARM: S3C64XX: Staticise non-exported GPIO to interrupt functions
> >       ARM: S3C64XX: Tone down SDHCI debugging
> >       ARM: SMDK6410: Fix build with WM1190 disabled and WM1192 enabled
> >       ARM: SMDK6410: Update regulator names for debugfs compatiblity
> >
> >  arch/arm/mach-s3c64xx/clock.c         |    6 ++++++
> >  arch/arm/mach-s3c64xx/dma.c           |   11 ++++++-----
> >  arch/arm/mach-s3c64xx/gpiolib.c       |    4 ++--
> >  arch/arm/mach-s3c64xx/mach-smdk6410.c |   13 +++++++------
> >  arch/arm/mach-s3c64xx/setup-sdhci.c   |    2 +-
> >  arch/arm/plat-samsung/dev-uart.c      |    2 ++
> >  6 files changed, 24 insertions(+), 14 deletions(-)
> 
> --
> Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/
> 
> Large Hadron Colada: A large Pina Colada that makes the universe
disappear.
