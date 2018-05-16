From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 May 2018 09:19:48 -0700
Subject: [PATCH 01/14] ARM: add CPU part numbers for Cortex A73, A75 and
 Brahma B15
In-Reply-To: <E1fIuAk-0003ja-BC@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuAk-0003ja-BC@rmk-PC.armlinux.org.uk>
Message-ID: <bc453cc5-aec7-8eb5-83a9-c6c2ae22e05a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 04:00 AM, Russell King wrote:
> Add CPU part numbers for the above mentioned CPUs
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/include/asm/cputype.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cb546425da8a..adc4a3eef815 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -77,8 +77,13 @@
>  #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
>  #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
>  #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
> +#define ARM_CPU_PART_CORTEX_A73		0x4100d090
> +#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
>  #define ARM_CPU_PART_MASK		0xff00fff0
>  
> +/* Broadcom cores */
> +#define ARM_CPU_PART_BRAHMA_B15		0x420000f0

For B15:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> +
>  /* DEC implemented cores */
>  #define ARM_CPU_PART_SA1100		0x4400a110
>  
> 


-- 
Florian
