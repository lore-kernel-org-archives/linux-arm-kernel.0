From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 15 Apr 2014 11:26:48 +0200
Subject: [PATCH 1/2] ARM: berlin: add the LIBGPIO as a dependency for the
 BG2Q
In-Reply-To: <20140415170750.7721e907@xhacker>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140415170750.7721e907@xhacker>
Message-ID: <20140415092648.GB4584@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Tue, Apr 15, 2014 at 05:07:50PM +0800, Jisheng Zhang wrote:
> On Tue, 15 Apr 2014 01:07:24 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
[?]
> > diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> > index 291f1cac6c3d..c31968712095 100644
> > --- a/arch/arm/mach-berlin/Kconfig
> > +++ b/arch/arm/mach-berlin/Kconfig
> > @@ -28,6 +28,7 @@ config MACH_BERLIN_BG2Q
> >  	select CPU_V7
> >  	select HAVE_ARM_TWD if SMP
> >  	select HAVE_SMP
> > +	select ARCH_REQUIRE_GPIOLIB
> 
> alphabetically sort.

You're right, will do.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
