From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 5 Jan 2011 08:58:56 +0530
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <4D23E578.7030108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2011 01:52 AM, Russell King - ARM Linux wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/plat-spear/include/plat/memory.h b/arch/arm/plat-spear/include/plat/memory.h
> index 27a4aba..7e3599e 100644
> --- a/arch/arm/plat-spear/include/plat/memory.h
> +++ b/arch/arm/plat-spear/include/plat/memory.h
> @@ -15,6 +15,6 @@
>  #define __PLAT_MEMORY_H
> 
>  /* Physical DRAM offset */
> -#define PHYS_OFFSET            UL(0x00000000)
> +#define PLAT_PHYS_OFFSET               UL(0x00000000)
> 
>  #endif /* __PLAT_MEMORY_H */

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
