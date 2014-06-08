From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jun 2014 20:02:51 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406081452590.25775@knanqh.ubzr>
References: <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608001942.GM23430@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1406081356050.25775@knanqh.ubzr>
 <20140608182949.GP23430@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1406081452590.25775@knanqh.ubzr>
Message-ID: <20140608190251.GQ23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 08, 2014 at 02:55:03PM -0400, Nicolas Pitre wrote:
> On Sun, 8 Jun 2014, Russell King - ARM Linux wrote:
> > No, I was specifically thinking about the various iPAQ specific things
> > like the additional platform specific ATAGs that they invented with
> > zero reference to mainline, and then expected them to be accepted as-is.
> > 
> > I gave them a very clear message over that (which was "no way") and that
> > was essentially the last of their mainline submissions.
> 
> That's basically what I'm saying.  They were too lazy to fix their code.  
> But nothing prevented that otherwise. They certainly couldn't use the 
> "firmware is broken and too hard to update" excuse.

No, they just continued to use those ATAGs that they invented.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
