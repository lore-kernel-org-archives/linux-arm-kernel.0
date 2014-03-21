From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 22 Mar 2014 08:41:27 +0900
Subject: [PATCH 52/62] ARM: samsung: disable decompressor watchdog on
 exynos
In-Reply-To: <201403211714.26621.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-53-git-send-email-arnd@arndb.de>
 <021d01cf43f2$687999a0$396ccce0$@samsung.com>
 <201403211714.26621.arnd@arndb.de>
Message-ID: <010001cf455f$14254430$3c6fcc90$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 20 March 2014, Kukjin Kim wrote:
> > Arnd Bergmann wrote:
> > >
> > > The S3C_BOOT_ERROR_RESET option only works when using the
> > > samsung specific mach/uncompress.h implementation. The
> > > Exynos platform has now moved on to using the generic
> > > implementation instead, which does not support this.
> > >
> > Yeah, correct and I've applied to use the generic uncompress for other
> > Samsung SoCs into samsung tree and I sent to arm-soc a couple of days ago.
> > Even though it is not cleaned for regarding configs e.g.,
> > S3C_BOOT_ERROR_RESET yet, this is not used more.
> >
> 
> Ok, dropping my patch for now.
> 
Thanks,
Kukjin
