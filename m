From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Mar 2017 14:38:14 +0000
Subject: [PATCH v2] KVM: arm/arm64: Let vcpu thread modify its own active
 state
In-Reply-To: <1488807757-86131-1-git-send-email-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Mon, 6 Mar 2017 05:42:37 -0800")
References: <1488807757-86131-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <874lz631yh.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06 2017 at  1:42:37 pm GMT, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> From: Jintack Lim <jintack@cs.columbia.edu>
>
> Currently, if a vcpu thread tries to change the active state of an
> interrupt which is already on the same vcpu's AP list, Since the VGIC
> mmio handler is called after a vcpu has already synced back the LR state
> to the struct vgic_irq, we can just let it proceed safely.
>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
