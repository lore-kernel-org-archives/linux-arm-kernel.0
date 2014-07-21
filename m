From: drake@endlessm.com (Daniel Drake)
Date: Mon, 21 Jul 2014 13:43:53 +0100
Subject: [PATCH] ARM: dts: add CPU nodes for Exynos4 SoCs
In-Reply-To: <1863399.9O2S91ZvEO@amdc1032>
References: <1863399.9O2S91ZvEO@amdc1032>
Message-ID: <CAD8Lp46eB3cDqD+1YMnWOG-V8CG7fCG1s2KH7znL0OrHSazRcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 5:00 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Recent patch by Tomasz Figa ("irqchip: gic: Fix core ID calculation
> when topology is read from DT") fixed GIC driver to filter cluster ID
> from values returned by cpu_logical_map() for SoCs having registers
> mapped without per-CPU banking making it is possible to add CPU nodes
> for Exynos4 SoCs.  In case of Exynos SoCs these CPU nodes are also
> required by future changes adding initialization of cpuidle states in
> Exynos cpuidle driver through DT.

This conflicts with work in the thread "cpufreq: use generic cpufreq
drivers for exynos platforms" which is already in its 7th iteration.
Perhaps best to work directly with Thomas to help him finish that series?

Daniel
