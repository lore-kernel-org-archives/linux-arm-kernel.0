From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Jun 2015 17:13:46 +0000
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <20150619154850.GT7557@n2100.arm.linux.org.uk>
References: <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
 <20150619152552.GF2936@io.lakedaemon.net>
 <20150619154850.GT7557@n2100.arm.linux.org.uk>
Message-ID: <20150619171346.GG2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 04:48:50PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 19, 2015 at 03:25:52PM +0000, Jason Cooper wrote:
> > Let's just get the dts patch reviewed and merged first.  Russell
> > actually wrote the patch to do what he's describing for mach-dove.
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309684.html
> > 
> > Although, it looks like it never got updated for submission...
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311800.html
> 
> I do still have that patch, it's based on v4.0 though - like all my
> Dove work, it only builds on the previous -final kernel release.

Benjamin, after the dts, would you mind picking up Russell's dove patch and
making a cooresponding orion5x patch?

thx,

Jason.
