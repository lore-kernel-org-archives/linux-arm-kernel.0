From: arm-kernel@ml.breakpoint.cc (Sebastian Andrzej Siewior)
Date: Mon, 12 Aug 2013 21:52:55 +0200
Subject: [patch 1/2] arm: Mark pmu interupt IRQF_NO_THREAD
In-Reply-To: <20130215095153.GA11145@mudshark.cambridge.arm.com>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.923585891@linutronix.de>
 <20130215095153.GA11145@mudshark.cambridge.arm.com>
Message-ID: <20130812195255.GA4181@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 09:51:53AM +0000, Will Deacon wrote:
> Yup, we certainly don't want these to be threaded! Cheers, I'll add this to
> my perf queue.

I don't see this in v3.10. Is there a problem with this patch?

> Will

Sebastian
