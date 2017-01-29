From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 29 Jan 2017 12:52:30 -0800
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
Message-ID: <1485723150.30797.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-29 at 22:08 +0200, Baruch Siach wrote:
> Add bcm2836 (Raspberry Pi 2) and bcm2837 (Raspberry Pi 3).
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> ?MAINTAINERS | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26edd832c64e..d69449735876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2612,7 +2612,7 @@ N:	bcm216*
> ?N:	kona
> ?F:	arch/arm/mach-bcm/
> ?
> -BROADCOM BCM2835 ARM ARCHITECTURE
> +BROADCOM BCM2835/BCM2836/BCM2837 ARM ARCHITECTURE
> ?M:	Stephen Warren <swarren@wwwdotorg.org>
> ?M:	Lee Jones <lee@kernel.org>
> ?M:	Eric Anholt <eric@anholt.net>
> @@ -2620,7 +2620,7 @@ L:	linux-rpi-kernel at lists.infradead.org
> (moderated for non-subscribers)
> ?L:	linux-arm-kernel at lists.infradead.org (moderated for non-
> subscribers)
> ?T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
> ?S:	Maintained
> -N:	bcm2835
> +N:	bcm283[5-7x]
> ?F:	drivers/staging/vc04_services
> ?
> ?BROADCOM BCM47XX MIPS ARCHITECTURE

This is all cool and whatnot, but being new I'm a bit confused how this
works.

1. Is everything still going to be e-mail based, because the e-mail
based system could use some improvement.

2. Are all the BCM283* files going to be clustered together or still
scattered through the tree?

3. Why do the branches of the git all contain very old versions of the
kernel?
