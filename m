From: dsaxena@plexity.net (Deepak Saxena)
Date: Fri, 5 Aug 2011 07:59:45 -0700
Subject: [PATCH 01/12] ARM: Remove LATCH reference for time-acorn.c
In-Reply-To: <20110805092323.GB20575@n2100.arm.linux.org.uk>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804134437.GB919@plexity.net>
	<20110805092323.GB20575@n2100.arm.linux.org.uk>
Message-ID: <20110805145945.GA12779@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 05 2011, at 10:23, Russell King - ARM Linux was caught saying:
> On Thu, Aug 04, 2011 at 06:44:37AM -0700, Deepak Saxena wrote:
> > +#define ACORN_TICK_RATE         2000000
> > +#define ACORN_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)
> 
> And also these should all be DIV_ROUND_CLOSEST(xxx_TICK_RATE, HZ)

Ack. Will update all patches and post an updated version with
some other fixes.

~Deepak

-- 
"People think all we need to fix our predicament is a free source of
energy, but I think we need to change out behaviour. More energy would
just deplete the Earth's lifeblood faster." - Janine Benyius
