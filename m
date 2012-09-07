From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:21:56 +0000
Subject: [PATCH] ARM: ks8695: add board support for the OpenGear boards
 based on the KS8695
In-Reply-To: <1346996139-5692-1-git-send-email-gerg@snapgear.com>
References: <1346996139-5692-1-git-send-email-gerg@snapgear.com>
Message-ID: <201209071221.56938.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, gerg at snapgear.com wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> A number of boards produced by OpenGear and based on the Micrel KS8695 SoC.
> Add board support to the KS8695 kernel code to support them.
> 
> The following machine type entries will need to be added back into the
> mach-types file with these in mainline:
> 
>     cm4008      MACH_CM4008       CM4008       624
>     cm41xx      MACH_CM41XX       CM41XX       672
>     cm4002      MACH_CM4002       CM4002       876
>     im42xx      MACH_IM42XX       IM42XX       1105
>     im4004      MACH_IM4004       IM4004       1400
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
---

Hi Greg,

Both ks8695 patches look good to me, I think we can apply them to the
arm-soc tree right away. If you agree, I'd also like to apply the
patch below to list you as a contact for the platform. If you prefer,
we can also list it as Maintained.

	Arnd

8<----
ARM: ks8695: add maintainers entry

Greg Ungerer has hardware for this platform and is testing it
regularly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc0119..f7b8d14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -913,6 +913,12 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
 S:	Maintained
 F:	arch/arm/mach-orion5x/ts78xx-*
 
+ARM/MICREL KS8695 ARCHITECTURE
+M:	Greg Ungerer <gerg@uclinux.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+F:	arch/arm/mach-ks8695
+S:	Odd Fixes
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
