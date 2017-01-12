From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Jan 2017 11:31:55 +0000
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
 <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
Message-ID: <891006af-9b82-59e8-b91e-ccf1399726a0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/17 22:04, Kim Phillips wrote:
> On Tue, 3 Jan 2017 18:10:26 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
>> +#define DRVNAME				"arm_spe_pmu"
> 
> Based on Intel naming "intel_pt" and "intel_bts', I had expected
> "arm-spe" as the universal basename for SPE.  I don't really care about
> whether '_pmu' is included, but it's yet another naming inconsistency we
> have with coresight's "cs_etm" (the other being prefixed with "arm_").
> 
> Also, nit, since I don't know why perf userspace tools can't handle
> dashes in PMU names (commit 3d1ff755e367 "arm: perf: clean up PMU
> names" doesn't say), can we at least start to use dashes in our
> filenames?  arm-spe-pmu.c is easier to type than arm_spe_pmu.c.

Fortunately, not everyone is using a UK/US keyboard... ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
