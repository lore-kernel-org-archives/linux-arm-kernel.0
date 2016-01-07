From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 10:23:12 +0000
Subject: [PATCH v8 03/20] KVM: ARM64: Add offset defines for PMU registers
In-Reply-To: <1450771695-11948-4-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-4-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <568E3C90.4010305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/15 08:07, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> We are about to trap and emulate accesses to each PMU register
> individually. This adds the context offsets for the AArch64 PMU
> registers.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
