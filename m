From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Aug 2013 12:11:17 +0100
Subject: [patch 1/2] arm: Mark pmu interupt IRQF_NO_THREAD
In-Reply-To: <20130812195255.GA4181@breakpoint.cc>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.923585891@linutronix.de>
 <20130215095153.GA11145@mudshark.cambridge.arm.com>
 <20130812195255.GA4181@breakpoint.cc>
Message-ID: <20130813111117.GB30280@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:52:55PM +0100, Sebastian Andrzej Siewior wrote:
> On Fri, Feb 15, 2013 at 09:51:53AM +0000, Will Deacon wrote:
> > Yup, we certainly don't want these to be threaded! Cheers, I'll add this to
> > my perf queue.
> 
> I don't see this in v3.10. Is there a problem with this patch?

Nope, I was just waiting for the discussion to die down around the kconfig
change in the second patch.

Probably best to submit both to Russell's patch system[1], with my ack on
this one:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

[1] Add a "KernelVersion: 3.11-rc5" line to the patch, then git send-email
    it to patches at arm.linux.org.uk.
