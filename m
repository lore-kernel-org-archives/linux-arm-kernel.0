From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Jan 2016 13:39:34 +0000
Subject: [PATCH v8 18/20] KVM: ARM64: Reset PMU state when resetting vcpu
In-Reply-To: <1450771695-11948-19-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-19-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160107133934.6a1c2228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 16:08:13 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When resetting vcpu, it needs to reset the PMU state to initial status.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
