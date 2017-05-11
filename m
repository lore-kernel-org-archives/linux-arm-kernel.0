From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 May 2017 08:40:28 +0100
Subject: [PATCH v1 2/2] KVM: arm: rename pm_fake handler to trap_raz_wi
In-Reply-To: <20170510170200.13285-3-alex.bennee@linaro.org>
References: <20170510170200.13285-1-alex.bennee@linaro.org>
 <20170510170200.13285-3-alex.bennee@linaro.org>
Message-ID: <abe33184-df28-2604-23db-ef4cdd3a9da7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/17 18:01, Alex Benn?e wrote:
> From: Zhichao Huang <zhichao.huang@linaro.org>
> 
> pm_fake doesn't quite describe what the handler does (ignoring writes
> and returning 0 for reads).
> 
> As we're about to use it (a lot) in a different context, rename it
> with a (admitedly cryptic) name that make sense for all users.
> 
> Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
> Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
