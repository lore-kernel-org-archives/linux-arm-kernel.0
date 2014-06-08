From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jun 2014 19:29:49 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406081356050.25775@knanqh.ubzr>
References: <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608001942.GM23430@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1406081356050.25775@knanqh.ubzr>
Message-ID: <20140608182949.GP23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 08, 2014 at 02:26:43PM -0400, Nicolas Pitre wrote:
> On Sun, 8 Jun 2014, Russell King - ARM Linux wrote:
> 
> > On Sat, Jun 07, 2014 at 04:53:34PM -0700, Olof Johansson wrote:
> > > You do realize that you have absolutely zero leverage over us on this,
> > > right? Our product is already shipped with kernel code that fixes
> > > this.
> > 
> > That is never a justification for forcing /any/ code into the kernel.
> > 
> > We've been here before with the iPAQs, where there were all sorts of
> > horrid hacks that were in the code for that device, and we said no to
> > it, and we kept it out of the mainline kernel, and stopped those hacks
> > polluting elsewhere (because people got to know on the whole that if
> > they used those hacks, it would bar them from mainline participation.)
> 
> That's different.  The iPaq had very little in terms of firmware, and 
> the one it had was field upgradable with almost no risk to brick it 
> (unless you wanted to hack the firmware code but that's another story).  
> The reason iPaq had never been well supported in mainline can be 
> attributed to laziness for not wanting to make the code into a shape 
> acceptable for mainline inclusion.  But nothing fundamentally prevented 
> that from happening if someone had wanted to do it.

No, I was specifically thinking about the various iPAQ specific things
like the additional platform specific ATAGs that they invented with
zero reference to mainline, and then expected them to be accepted as-is.

I gave them a very clear message over that (which was "no way") and that
was essentially the last of their mainline submissions.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
