From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Jul 2015 23:06:03 +0200
Subject: Gemini Soc timers
In-Reply-To: <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
 <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
Message-ID: <9777530.lnQDW33Iqo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 July 2015 10:48:26 Linus Walleij wrote:
> On Thu, Jul 9, 2015 at 6:48 PM, Roman Yeryomin <roman@advem.lv> wrote:
> > [Me]
> >> As usual they are just keeping it out of mainline, and this
> >> is adding sched_clock() and other goodies so should
> >> probably be upstreamed ASAP.
> >
> >
> > This is what I initially submitted here.
> 
> Ah. I missed part of the start of the discussion it seems.
> 
> > But Arnd wanted to see a smaller patch which only fixes gemini timer issue
> > (t.i. shed clock being 100Hz instead of 25MHz).
> > Also I've submitted 4.1 support yesterday, but patches didn't change much
> > comparing to 3.18
> 
> On the other hand I think the bigger patch is OK actually.
> 
> I rewrote the timer support some time back and did not get
> anyone to test it properly at the time, so the patch went in
> untested. So this is a fix.

The bigger patch seemed a little too verbose to have it backported
to stable kernels, so I asked for a minimal fix that could be marked
as stable, with the other changes applied on top for the current
arm-soc tree.

I'm still on parental leave and not dealing with patches directly,
so whichever patch we want should get routed through Ulli to arm at kernel.org

	Arnd
