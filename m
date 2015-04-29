From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 29 Apr 2015 08:29:45 -0700
Subject: [OT] Profiling on ARM Linux systems: how?
In-Reply-To: <mhqrbj$vlu$1@ger.gmane.org>
References: <mhqrbj$vlu$1@ger.gmane.org>
Message-ID: <1516029.oc3LenLXRM@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 29, 2015 02:54:43 PM Grant Edwards wrote:
> This might be a little off-topic. If so I apologize.
Probably.

> 
> I have a problem with excessive CPU usage on an embedded ARM926
> system.  There are three main apps, all of which have multiple
> threads. The total CPU usage is too high.  I'm trying to figure out
> where the CPU time is "going" so we know were to concentrate
> optimization efforts.
> 
> The "top" utility is useless because it samples at a fixed interval.
> Almost all of the threads are driven by timers on fixed cycles (or
> data from threads that are). The 'top' sampling method appears to
> cause aliasing which renders the numbers shown by top meaningless.
> 
...

> 
> Any advice?

At my company we have found perf top more useful than top
for finding performance problems that might include kernel interaction.
perf has a number of other goodies as well that are worth a look.
Beyond that, idk.

-- 
~Joshua Clayton
