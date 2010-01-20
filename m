From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 20 Jan 2010 14:39:39 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <20100120133145.GE4089@wear.picochip.com>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
Message-ID: <1263994779.4283.1057.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-20 at 13:31 +0000, Jamie Iles wrote:
> Personally I think this is a good idea. At the moment 'perf list' gives lots
> of events that the system isn't capable of counting. Admittedly it's fairly
> easy to see if they are supported but it would be nice if the list reflected
> the countable events. perf already does this for the tracing events so it
> would be nice if it did the same for the hardware events. I guess the same
> hierarchy would be nice too. 

This seems to be missing the patch that extends perf list to report the
support and counting status for the events on the current machine :-)

Furthermore, /proc/cpuinfo should be enough information to come up with
an arch specific set of events to be translated into raw.
