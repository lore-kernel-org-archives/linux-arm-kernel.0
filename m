From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 10:20:21 +0000
Subject: [PATCH v8 01/20] ARM64: Move PMU register related defines to
 asm/pmu.h
In-Reply-To: <1450771695-11948-2-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-2-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <568E3BE5.8080000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/15 08:07, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> To use the ARMv8 PMU related register defines from the KVM code,
> we move the relevant definitions to asm/pmu.h header file.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
