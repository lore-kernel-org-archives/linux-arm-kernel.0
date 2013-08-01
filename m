From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 21:18:23 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801201539.GA12291@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130801193936.GD23006@n2100.arm.linux.org.uk>
 <20130801201539.GA12291@kroah.com>
Message-ID: <20130801201823.GF23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 04:15:39AM +0800, Greg KH wrote:
> I'm not saying move away from DT at all, if it can be used to describe
> stuff like this, wonderful.  Just please don't use platform_bus anymore
> than you have to.

As far as that sentiment goes, it would have been nice if that was made
more vocally ten years ago, because at that time I was the one trying to
encourage people to think about creating appropriate bus types, and what
I was being told was that no, bus types are something which are deprecated
and platform bus is what should be used.

I get sick and tired of being told "this is what you should do" only to
find out years later that the people saying what should be done have
completely changed their minds - or the maintainers have changed and
they have completely the reverse decision.

We are here with platform_bus precisely becuase that's the way people
working on the ARM architecture were told to do.
