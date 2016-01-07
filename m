From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 10:21:45 +0000
Subject: [PATCH v8 02/20] KVM: ARM64: Define PMU data structure for each
 vcpu
In-Reply-To: <1450771695-11948-3-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-3-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <568E3C39.2020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/15 08:07, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Here we plan to support virtual PMU for guest by full software
> emulation, so define some basic structs and functions preparing for
> futher steps. Define struct kvm_pmc for performance monitor counter and
> struct kvm_pmu for performance monitor unit for each vcpu. According to
> ARMv8 spec, the PMU contains at most 32(ARMV8_MAX_COUNTERS) counters.
> 
> Since this only supports ARM64 (or PMUv3), add a separate config symbol
> for it.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
