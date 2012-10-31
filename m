From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 31 Oct 2012 09:35:02 +0800
Subject: [PATCH V3 0/7] ARM: tegra30: cpuidle: add a powered-down state
In-Reply-To: <50905876.70108@wwwdotorg.org>
References: <1351506501-600-1-git-send-email-josephl@nvidia.com>
 <50905876.70108@wwwdotorg.org>
Message-ID: <1351647302.5410.41.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-31 at 06:45 +0800, Stephen Warren wrote:
> On 10/29/2012 04:28 AM, Joseph Lo wrote:
> > This adds a "powered-down" state for cpuidle. It's a power gating idle
> > mode. It supports the secondary CPUs (i.e., CPU1-CPU3) to go into
> > powered-down state independently. When any of the secondary CPUs go into
> > this state, it can be power gated alone. There is a limitation on CPU0.
> > The CPU0 can go into powered-down state only when all secondary CPU is
> > offline. After CPU0 is in powered-down state, the CPU rail can be turned
> > off.
> 
> This series doesn't seem to apply to Tegra's current for-next, nor
> next-20121029. What is it based on?
> 
> Note: I did try merging "ARM: tegra: rename the file of "sleep-tXX" to
> "sleep-tegraXX"" first, since I assume that's a dependency.

Hi Stephen,

This patch set were based on next-20121026. I saw the new update for
moving some header files on the latest "next" branch. It may cause some
conflicts. I will update a new one later.

Thanks,
Joseph
