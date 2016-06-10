From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:04:14 -0700
Subject: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI
 platforms
In-Reply-To: <20160519044744.GE32001@vireshk-i7>
References: <cover.1463606963.git.d-gerlach@ti.com>
 <20160519044744.GE32001@vireshk-i7>
Message-ID: <20160610110414.GX22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Viresh Kumar <viresh.kumar@linaro.org> [160518 21:49]:
> On 18-05-16, 18:36, Dave Gerlach wrote:
> > Hi,
> > This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
> > and am57xx based platforms along with some support patches so that we
> > can enable more OPPs for the CPU on these platforms.
> > 
> > These patches rely on the ti-cpufreq series sent here [1] and provide
> > opp-supported-hw data for each OPP so that only the appropriate OPPs
> > for a specific piece of silicon get enabled.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applying all the dts changes into omap-for-v4.8/dt thanks.

Tony
