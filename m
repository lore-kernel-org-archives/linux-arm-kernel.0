From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 11:20:03 +0100
Subject: [PATCH v9 04/12] KVM: Documentation: Add info regarding
 KVM_ARM_VCPU_PSCI_0_2 feature
In-Reply-To: <1397542455-354-5-git-send-email-anup.patel@linaro.org> (Anup
 Patel's message of "Tue, 15 Apr 2014 07:14:07 +0100")
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-5-git-send-email-anup.patel@linaro.org>
Message-ID: <8738he28to.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15 2014 at  7:14:07 am BST, Anup Patel <anup.patel@linaro.org> wrote:
> We have in-kernel emulation of PSCI v0.2 in KVM ARM/ARM64. To provide
> PSCI v0.2 interface to VCPUs, we have to enable KVM_ARM_VCPU_PSCI_0_2
> feature when doing KVM_ARM_VCPU_INIT ioctl.
>
> The patch updates documentation of KVM_ARM_VCPU_INIT ioctl to provide
> info regarding KVM_ARM_VCPU_PSCI_0_2 feature.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
>  Documentation/virtual/kvm/api.txt |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index a9380ba5..6dc1db5 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2376,6 +2376,8 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI.
>  	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>  	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
> +	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 for the CPU.
> +	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  
>  
>  4.83 KVM_ARM_PREFERRED_TARGET

-- 
Jazz is not dead. It just smells funny.
