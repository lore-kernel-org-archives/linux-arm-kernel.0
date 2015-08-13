From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:21:44 +0200
Subject: [GIT PULL 2nd 3/4] Samsung driver 2nd updates for v4.3
In-Reply-To: <55CBE10B.2030103@kernel.org>
References: <55CBE10B.2030103@kernel.org>
Message-ID: <20150813092144.GD30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 09:12:59AM +0900, Kukjin Kim wrote:
> Hi,
> 
> I've created the signed tag based on previous tags/samsung-driver so you
> can see several merge in there. To support cpufreq-dt driver requires
> clk/cpufreq/exynos changes together and clk/cpufreq maintainers are
> aware of this changes. And we can remove exynos cpufreq driver at last.
> 
> Note this drivers update is including previous dependencies and if
> you're OK, please pull.

Again, this needs to be revisited.

Please try to keep the dependency only driver->dt if you can,
and we can merge drivers before DT this release cycle. If you do
driver->dt->driver->dt like here then things get messy.


-Olof
