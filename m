From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 7 Jul 2014 01:49:48 -0700
Subject: [PATCH] arm64: KVM: allow export and import of generic timer regs
In-Reply-To: <1404485654-32674-1-git-send-email-alex.bennee@linaro.org>
References: <1404485654-32674-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <20140707084948.GE20451@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 03:54:14PM +0100, Alex Benn?e wrote:
> For correct guest suspend/resume behaviour we need to ensure we include
> the generic timer registers for 64 bit guests. As CONFIG_KVM_ARM_TIMER is
> always set for arm64 we don't need to worry about null implementations.
> However I have re-jigged the kvm_arm_timer_set/get_reg declarations to
> be in the common include/kvm/arm_arch_timer.h headers.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
