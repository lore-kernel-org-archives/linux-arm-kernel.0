From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Aug 2014 21:30:28 +0200
Subject: [PATCH v3] arm/smp: Absorb boot_secondary()
In-Reply-To: <CAMuHMdXp0ruZjjJLXmWyCdfAXs9_9xFHDcmJ08M9_SbZqqq04g@mail.gmail.com>
References: <1404918119-3676-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXp0ruZjjJLXmWyCdfAXs9_9xFHDcmJ08M9_SbZqqq04g@mail.gmail.com>
Message-ID: <201408202130.28389.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 August 2014, Geert Uytterhoeven wrote:
> 
> Ping?
> 
> On Wed, Jul 9, 2014 at 5:01 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > After becoming a mandatory function, boot_secondary() is no longer used
> > outside arch/arm/kernel/smp.c. Hence remove its public prototype, and,
> > as suggested by Arnd, let it be absorbed by its single caller.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>

I think you should add the patch to Russell's patch tracking system
at http://www.arm.linux.org.uk/developer/patches to get it applied.

	Arnd
