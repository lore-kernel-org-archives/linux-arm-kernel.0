From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 09 Oct 2015 10:30:31 +0300
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <00e601d10264$61cdafb0$25690f10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> +  KVM_DEV_ARM_VGIC_CPU_SYSREGS
> +  Attributes:
> +    The attr field of kvm_device_attr encodes two values:
> +    bits:     | 63      ....       32 | 31  ....  16 | 15  ....  0 |
> +    values:   |         mpidr         |      RES     |    instr    |

 One small clarification: do you really want it to be different from KVM_DEV_ARM_VGIC_GRP_CPU_REGS?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
