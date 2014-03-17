From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 16 Mar 2014 20:39:38 -0700
Subject: [PATCH v4 01/10] KVM: Add capability to advertise PSCI v0.2
 support
In-Reply-To: <1391686302-19451-2-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-2-git-send-email-anup.patel@linaro.org>
Message-ID: <20140317033938.GB20648@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 05:01:33PM +0530, Anup Patel wrote:
> User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
> ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
> define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  include/uapi/linux/kvm.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 932d7f2..fb3c3f3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -675,6 +675,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_SPAPR_MULTITCE 94
>  #define KVM_CAP_EXT_EMUL_CPUID 95
>  #define KVM_CAP_HYPERV_TIME 96
> +#define KVM_CAP_ARM_PSCI_0_2 97
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 1.7.9.5
> 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
