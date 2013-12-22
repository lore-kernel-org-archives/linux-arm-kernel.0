From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 21 Dec 2013 23:00:23 -0500
Subject: [RFC PATCH v5 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131221215424.GA31584@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
 <1387316473-3250-2-git-send-email-andrew@lunn.ch>
 <20131220033257.GF2609@titan.lakedaemon.net>
 <20131221162645.GE20115@lunn.ch>
 <20131221192500.GG2609@titan.lakedaemon.net>
 <20131221215424.GA31584@lunn.ch>
Message-ID: <20131222040023.GI2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 10:54:24PM +0100, Andrew Lunn wrote:
> On Sat, Dec 21, 2013 at 02:25:01PM -0500, Jason Cooper wrote:
> > Andrew,
> > 
> > On Sat, Dec 21, 2013 at 05:26:45PM +0100, Andrew Lunn wrote:
> > > > > +Dove cpufreq driver
> > > > > +-------------------
> > > > > +
> > > > > +The Dove cpufreq driver makes use of the pmu node in the device tree.
> > > > 
> > > > I would prefer to reword this to make it OS-agnostic.  The cpufreq
> > > > driver is Linux-specific.
> > > 
> > > Why is it Linux specific? 
> > 
> > I'll admit I may be bike-shedding here, and I'm more seeking
> > opinion/clarification than mandating anything.  The above sentence,
> > imho, is describing how Linux/FreeBSD uses the node, not describing the
> > hardware.
> 
> How about:
> 
> Dove has a PMU, which contains DFS, DVS, RTC, clock gates, and thermal
> management,


Yep, much better.

thx,

Jason.
