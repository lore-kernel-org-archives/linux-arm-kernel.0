From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Jul 2014 08:30:41 +0100
Subject: [PATCH] arm64: KVM: allow export and import of generic timer regs
In-Reply-To: <1404485654-32674-1-git-send-email-alex.bennee@linaro.org> ("Alex
 \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\= message of "Fri,
 4 Jul 2014 15:54:14 +0100")
References: <1404485654-32674-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <87mwclbp7i.fsf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04 2014 at  3:54:14 pm BST, Alex Benn?e <alex.bennee@linaro.org> wrote:
> For correct guest suspend/resume behaviour we need to ensure we include
> the generic timer registers for 64 bit guests. As CONFIG_KVM_ARM_TIMER is
> always set for arm64 we don't need to worry about null implementations.
> However I have re-jigged the kvm_arm_timer_set/get_reg declarations to
> be in the common include/kvm/arm_arch_timer.h headers.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
