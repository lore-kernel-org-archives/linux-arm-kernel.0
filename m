From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 12 Mar 2013 13:30:39 -0400
Subject: [PATCH 12/29] arm64: KVM: kvm_arch and kvm_vcpu_arch definitions
In-Reply-To: <1362455265-24165-13-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-13-git-send-email-marc.zyngier@arm.com>
Message-ID: <513F663F.8040200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> Provide the architecture dependent structures for VM and
> vcpu abstractions.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 178 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kvm_host.h
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> new file mode 100644
> index 0000000..d1095d1
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_host.h

[...]

> +struct kvm_vcpu_fault_info {
> +	u32 esr_el2;		/* Hyp Syndrom Register */

Syndrome

> +	u64 far_el2;		/* Hyp Fault Address Register */
> +	u64 hpfar_el2;		/* Hyp IPA Fault Address Register */
> +};

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
