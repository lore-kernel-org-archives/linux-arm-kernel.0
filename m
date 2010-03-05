From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 05 Mar 2010 14:30:31 +0000
Subject: [PATCH] ARM: Realview/Versatile/Integrator: separate outcommon
	clock code
In-Reply-To: <000001cabc52$b2514090$16f3c1b0$@tuckley@arm.com>
References: <000001cabc52$b2514090$16f3c1b0$@tuckley@arm.com>
Message-ID: <1267799431.23338.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-05 at 10:57 +0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King
> 
> > +     select PLAT_VERSATILE
> 
> This needs to be called something else if it's going to be used for
> mach-realview and mach-integrator. It's too confusing because of there being
> a mach-versatile. It needs to be a more generic name, something that isn't a
> mach. Perhaps "ARMDEV".

I'm ok with the plat-versatile name and I don't think we should argue
much about this. That's just a Linux internal name and it isn't visible
to someone compiling the kernel.

-- 
Catalin
