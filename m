From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Apr 2014 23:16:12 +0200 (CEST)
Subject: [patch 0/4] genirq/exynos timers: Fix the CPU hotplug wreckage
 sanely
In-Reply-To: <1397663995.19782.4.camel@AMDC1943>
References: <20140416142106.537575971@linutronix.de>
 <1397663995.19782.4.camel@AMDC1943>
Message-ID: <alpine.DEB.2.02.1404162315270.22697@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Krzysztof Kozlowski wrote:
> On ?ro, 2014-04-16 at 14:36 +0000, Thomas Gleixner wrote:
> > @Krzysztof: Can you please retest the series? I've changed the core
> > implementation versus the first attempt to make it less intrusive.
> 
> Works fine. Tested whole patchset on board with Exynos 3250.

Great! Now I just need to sell it :)
