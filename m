From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Jan 2018 18:02:33 +0000
Subject: [bug report] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <6457a5ff-21d7-0867-2cf1-3b5d08349e2e@arm.com>
References: <20180112201334.sfqjnyw4or4msfeq@mwanda>
 <6457a5ff-21d7-0867-2cf1-3b5d08349e2e@arm.com>
Message-ID: <20180115180232.zuxrgdwf2jfproth@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 10:51:16AM +0000, Suzuki K. Poulose wrote:
> perf: dsu: Use signed field for dsu_pmu->num_counters
> We set dsu_pmu->num_counters to -1, when the DSU is allocated
> but not initialised when none of the CPUs are active in the DSU.
> However, we use an unsigned field for num_counters. Switch this
> to a signed field.

Applied. Thanks.

-- 
Catalin
