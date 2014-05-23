From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 16:42:51 +0200
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <CACRpkdZ6oAO0sx-OwA-31FCPVWYeGH7zxmiog7OooMw_2_jzFA@mail.gmail.com>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <4921873.t2F8plV493@wuerfel>
 <CACRpkdZ6oAO0sx-OwA-31FCPVWYeGH7zxmiog7OooMw_2_jzFA@mail.gmail.com>
Message-ID: <4624104.VNbedVmtTU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014 15:48:17 Linus Walleij wrote:
> On Tue, May 20, 2014 at 10:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Ah, right. I see these two includes from mach-versatile to plat/*.h headers:
> >
> > arch/arm/mach-versatile/core.c:#include <plat/clcd.h>
> 
> I have a patch for this one.
> 
> > arch/arm/mach-versatile/core.c:#include <plat/sched_clock.h>
> 
> In the Integrator I solved this by inlining that code into the
> machine. After the introduction of sched_clock_register()
> this becomes very few lines of code really.

Ah, very good.

	Arnd
