From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Jan 2016 13:51:15 +0000
Subject: [PATCH v8 19/20] KVM: ARM64: Free perf event of PMU when
 destroying vcpu
In-Reply-To: <1450771695-11948-20-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-20-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160107135115.47b3d0b1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 16:08:14 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When KVM frees VCPU, it needs to free the perf_event of PMU.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
