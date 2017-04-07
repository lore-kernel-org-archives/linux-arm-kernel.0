From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 7 Apr 2017 10:15:32 +0200 (CEST)
Subject: [PATCH v3 00/18] clocksource/arch_timer: Errata workaround
 infrastructure rework
In-Reply-To: <e89c2826-85e1-74f4-de73-e4c18b2e7ec9@linaro.org>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
 <20170406162714.GC7705@e104818-lin.cambridge.arm.com>
 <e89c2826-85e1-74f4-de73-e4c18b2e7ec9@linaro.org>
Message-ID: <alpine.DEB.2.20.1704071010020.1716@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Apr 2017, Daniel Lezcano wrote:
> On 06/04/2017 18:27, Catalin Marinas wrote:
> > Are you happy to take the arch_timer patches above? If yes, Marc can
> > create a common branch with the first 5 patches which I will merge in
> > the arm64 tree. You can then pull the whole series into your tree.
> 
> Hi Catalin,
> 
> I'm fine with the merge process you are proposing. But before going
> forward, I would like to wait a bit in order to give the opportunity to
> Thomas to review the patchset.

I'm fine with that. It's sad that we need to have a workaround framework
for dealing with this, but silicon tinkerers seem to compete on providing
the most broken implementation of an _architected_ timer.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
