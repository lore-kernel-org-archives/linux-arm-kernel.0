From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 23:06:11 +0200
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <1485723150.30797.1.camel@crowfest.net>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
 <1485723150.30797.1.camel@crowfest.net>
Message-ID: <20170129210611.k46ey35py3ht3fe7@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sun, Jan 29, 2017 at 12:52:30PM -0800, Michael Zoran wrote:
> On Sun, 2017-01-29 at 22:08 +0200, Baruch Siach wrote:
> > Add bcm2836 (Raspberry Pi 2) and bcm2837 (Raspberry Pi 3).
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> > ?MAINTAINERS | 4 ++--
> > ?1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 26edd832c64e..d69449735876 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2612,7 +2612,7 @@ N:	bcm216*
> > ?N:	kona
> > ?F:	arch/arm/mach-bcm/
> > ?
> > -BROADCOM BCM2835 ARM ARCHITECTURE
> > +BROADCOM BCM2835/BCM2836/BCM2837 ARM ARCHITECTURE
> > ?M:	Stephen Warren <swarren@wwwdotorg.org>
> > ?M:	Lee Jones <lee@kernel.org>
> > ?M:	Eric Anholt <eric@anholt.net>
> > @@ -2620,7 +2620,7 @@ L:	linux-rpi-kernel at lists.infradead.org
> > (moderated for non-subscribers)
> > ?L:	linux-arm-kernel at lists.infradead.org (moderated for non-
> > subscribers)
> > ?T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
> > ?S:	Maintained
> > -N:	bcm2835
> > +N:	bcm283[5-7x]
> > ?F:	drivers/staging/vc04_services
> > ?
> > ?BROADCOM BCM47XX MIPS ARCHITECTURE
> 
> This is all cool and whatnot, but being new I'm a bit confused how this
> works.
> 
> 1. Is everything still going to be e-mail based, because the e-mail
> based system could use some improvement.

Kernel development is email based. See "Why kernel development still uses 
email"[1]. What would you like to see improved?

> 2. Are all the BCM283* files going to be clustered together or still
> scattered through the tree?

The hardware module type determines its driver location in the kernel tree. 
The i2c-bcm2835.c has much more in common with other i2c master drivers than 
with spi-bcm2835.c.

> 3. Why do the branches of the git all contain very old versions of the
> kernel?

Which git branches?

[1] https://lwn.net/Articles/702177/

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
