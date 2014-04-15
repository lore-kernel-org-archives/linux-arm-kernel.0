From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 15 Apr 2014 11:27:46 +0200
Subject: [PATCH 1/2] ARM: berlin: add the LIBGPIO as a dependency for the
 BG2Q
In-Reply-To: <534CF901.2080400@gmail.com>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-2-git-send-email-antoine.tenart@free-electrons.com>
 <534CF901.2080400@gmail.com>
Message-ID: <20140415092746.GC4584@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Tue, Apr 15, 2014 at 11:16:49AM +0200, Sebastian Hesselbarth wrote:
> On 04/15/2014 10:07 AM, Antoine T?nart wrote:

[?]

> >diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> >index 291f1cac6c3d..c31968712095 100644
> >--- a/arch/arm/mach-berlin/Kconfig
> >+++ b/arch/arm/mach-berlin/Kconfig
> >@@ -28,6 +28,7 @@ config MACH_BERLIN_BG2Q
> >  	select CPU_V7
> >  	select HAVE_ARM_TWD if SMP
> >  	select HAVE_SMP
> >+	select ARCH_REQUIRE_GPIOLIB
> 
> Apart from Jisheng's comment, I think we can directly move it
> into arch/arm/Kconfig's MACH_BERLIN directly?

I think so.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
