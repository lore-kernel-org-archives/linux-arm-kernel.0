From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 20:22:42 +0900
Subject: [PATCH 15/19] arm64: exynos5433: Enable ARMv8-based Exynos5433 SoC
 support
In-Reply-To: <20141127111839.GD11511@e104818-lin.cambridge.arm.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-16-git-send-email-cw00.choi@samsung.com>
 <20141127111839.GD11511@e104818-lin.cambridge.arm.com>
Message-ID: <54770982.3080502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2014 08:18 PM, Catalin Marinas wrote:
> On Thu, Nov 27, 2014 at 07:35:12AM +0000, Chanwoo Choi wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f4536e0..8a5e8a0 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -152,6 +152,16 @@ config ARCH_EXYNOS
>>  	help
>>  	  This enables support for Samsung Exynos SoC family
>>  
>> +config ARCH_EXYNOS5433
>> +	bool "ARMv8 based Samsung Exynos5433"
>> +	select ARCH_EXYNOS
>> +	select COMMON_CLK_SAMSUNG
>> +	select PINCTRL
>> +	select PINCTRL_EXYNOS
>> +
>> +	help
>> +	  This enables support for Samsung Exynos5433 SoC family
> 
> Please update defconfig as well to include this. We aim for the
> arm64 defconfig to build all the supported SoCs.
> 

OK, I'll add it.

Thanks for your review.

Best Regards,
Chanwoo Choi
