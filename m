From: c.jayachandran@gmail.com (Jayachandran C.)
Date: Thu, 27 Apr 2017 18:31:50 +0530
Subject: [PATCH 1/3] arm64: Add MIDR values for Cavium cn99xx SoCs
In-Reply-To: <1493293584-20287-2-git-send-email-gakula@caviumnetworks.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-2-git-send-email-gakula@caviumnetworks.com>
Message-ID: <CA+7sy7BX3hVG=Coh0Dy6iiAHWqKuEVz1c2Z58TQACbMPrvdyqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 5:16 PM, Geetha sowjanya
<gakula@caviumnetworks.com> wrote:
> From: Geetha <gakula@cavium.com>
>
> Add MIDR values for Cavium cn99xx SoCs
>
> Signed-off-by: Geetha <gakula@cavium.com>
> ---
>  arch/arm64/include/asm/cputype.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index fc50271..066fad0 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -85,6 +85,7 @@
>
>  #define CAVIUM_CPU_PART_THUNDERX       0x0A1
>  #define CAVIUM_CPU_PART_THUNDERX_81XX  0x0A2
> +#define CAVIUM_CPU_PART_THUNDERX_99XX  0x0AF

Can you please use the name CAVIUM_CPU_PART_THUNDERX2? We have used
ThunderX2 consistently for this platform, having THUNDERX here would
be confusing.

>  #define BRCM_CPU_PART_VULCAN           0x516
>
> @@ -94,6 +95,8 @@
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_THUNDERX  MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
>  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
> +#define MIDR_THUNDERX_99XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_99XX)
> +#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
>  #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
>
>  #ifndef __ASSEMBLY__

Thanks,
JC.
