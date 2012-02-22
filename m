From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 22 Feb 2012 18:28:52 +0100
Subject: [PATCH 1/2] ARM: S3C24XX: Move s3c2443-clock.c to mach-s3c24xx
In-Reply-To: <201202221718.01137.arnd@arndb.de>
References: <201202212221.41744.heiko@sntech.de>
 <201202212226.01189.heiko@sntech.de> <201202221718.01137.arnd@arndb.de>
Message-ID: <201202221828.53363.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 22 Februar 2012, 18:18:00 schrieb Arnd Bergmann:
> On Tuesday 21 February 2012, Heiko St?bner wrote:
> > S3C-SoCs starting with the S3C2443 can share a lot of functionality.
> > The file can collect more common code of these SocS later on and
> > therefore gets a new name to reflect this future purpose.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/mach-s3c24xx/Kconfig          |   14 +-
> >  arch/arm/mach-s3c24xx/Makefile         |    4 +
> >  arch/arm/mach-s3c24xx/common-s3c2443.c |  644
> >  ++++++++++++++++++++++++++++++++ arch/arm/plat-s3c24xx/Kconfig         
> >  |    6 -
> >  arch/arm/plat-s3c24xx/Makefile         |    1 -
> >  arch/arm/plat-s3c24xx/s3c2443-clock.c  |  635
> >  -------------------------------
> 
> No objections on the patch, but please use 'git format-patch -M' when
> moving files so that we can see which parts have changed in the process.
the results of -M look really nice, thanks for the hint and I will try to 
remember it :-)

Heiko
