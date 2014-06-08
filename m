From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jun 2014 01:19:43 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
Message-ID: <20140608001942.GM23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 04:53:34PM -0700, Olof Johansson wrote:
> You do realize that you have absolutely zero leverage over us on this,
> right? Our product is already shipped with kernel code that fixes
> this.

That is never a justification for forcing /any/ code into the kernel.

We've been here before with the iPAQs, where there were all sorts of
horrid hacks that were in the code for that device, and we said no to
it, and we kept it out of the mainline kernel, and stopped those hacks
polluting elsewhere (because people got to know on the whole that if
they used those hacks, it would bar them from mainline participation.)

There's many other instances.  Think about it - if we allowed this as
an acceptance criteria, then all that vendors have to do to get their
code into the kernel is change their development cycle: develop
product, ship product, force code into mainline as a done deal not
accepting any review comments back.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
