From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Tue, 16 Feb 2016 23:32:57 -0800
Subject: [PATCH 4/4] arm64: cputype info for Broadcom Vulcan
In-Reply-To: <1455389195-31870-5-git-send-email-jchandra@broadcom.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
 <1455389195-31870-5-git-send-email-jchandra@broadcom.com>
Message-ID: <CAMDttNc-L0_zg_skNg9CyVT8mGgyZQZTLgCdMMGExxwqhSSPDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 13, 2016 at 10:46 AM, Jayachandran C <jchandra@broadcom.com> wrote:
>
> Add Broadcom Vulcan implementor ID and part ID in cputype.h. This is
> to document the values.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/arm64/include/asm/cputype.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 1a59493..3725d59 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -65,6 +65,7 @@
>  #define ARM_CPU_IMP_ARM                        0x41
>  #define ARM_CPU_IMP_APM                        0x50
>  #define ARM_CPU_IMP_CAVIUM             0x43
> +#define ARM_CPU_IMP_BRCM               0x42

It's probably not a big deal... guessing this list is chronologically
ordered and should remain so?

>
>  #define ARM_CPU_PART_AEM_V8            0xD0F
>  #define ARM_CPU_PART_FOUNDATION                0xD00
> @@ -74,6 +75,7 @@
>  #define APM_CPU_PART_POTENZA           0x000
>
>  #define CAVIUM_CPU_PART_THUNDERX       0x0A1
> +#define BRCM_CPU_PART_VULCAN           0x516
>
>  #ifndef __ASSEMBLY__
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
