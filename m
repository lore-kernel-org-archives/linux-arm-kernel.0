From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 27 Feb 2015 23:11:00 +0100
Subject: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt
 lines
In-Reply-To: <1968084.K4YyaeZfBq@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150227083859.GD21418@twins.programming.kicks-ass.net>
 <1968084.K4YyaeZfBq@vostro.rjw.lan>
Message-ID: <20150227221100.GV5029@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 11:13:57PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 27, 2015 09:38:59 AM Peter Zijlstra wrote:

> > Seems good to me. Should I take this through tip/irq ?
> 
> I can apply it along with the previous IRQF_NO_SUSPEND documentation patch
> from Mark Rutland if you ACK it for me. :-)

Works for me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> > Also, should we warn if people use enable_irq_wake() where there is only
> > a single descriptor with NO_SUSPEND?
> 
> We probably should do that, but that would be a separate patch IMO?

Agreed. Just wanted to raise the point.
