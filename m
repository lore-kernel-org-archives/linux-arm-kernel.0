From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 28 Jan 2014 13:05:35 -0800
Subject: [RFC PATCH 3/3] KVM: Documentation: Add info regarding
 KVM_ARM_VCPU_PSCI_0_2 feature
In-Reply-To: <1390309301-28424-4-git-send-email-anup.patel@linaro.org>
References: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
 <1390309301-28424-4-git-send-email-anup.patel@linaro.org>
Message-ID: <20140128210535.GB26671@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 06:31:41PM +0530, Anup Patel wrote:
> We have in-kernel emulation of PSCI v0.2 in KVM ARM/ARM64. To provide
> PSCI v0.2 interface to VCPUs, we have to enable KVM_ARM_VCPU_PSCI_0_2
> feature when doing KVM_ARM_VCPU_INIT ioctl.
> 
> The patch updates documentation of KVM_ARM_VCPU_INIT ioctl to provide
> info regarding KVM_ARM_VCPU_PSCI_0_2 feature.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  Documentation/virtual/kvm/api.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index aad3244..a15fcdd 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2346,6 +2346,8 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI.
>  	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>  	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
> +	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 for CPU.

nit: s/for CPU/for the CPU/

> +	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  
>  
>  4.83 KVM_ARM_PREFERRED_TARGET
> -- 
> 1.7.9.5
> 
