From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 06 Oct 2014 15:05:41 +0200
Subject: [PATCH 2/4] [media] exynos4-is: Remove optional dependency on
 PLAT_S5P
In-Reply-To: <54328D18.2000606@cogentembedded.com>
References: <1412586485.4054.40.camel@x220>
 <54328D18.2000606@cogentembedded.com>
Message-ID: <543293A5.1090506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/14 14:37, Sergei Shtylyov wrote:
>> diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
>> index 77c951237744..775c3278d0eb 100644
>> --- a/drivers/media/platform/exynos4-is/Kconfig
>> +++ b/drivers/media/platform/exynos4-is/Kconfig
>> @@ -2,7 +2,7 @@
>>   config VIDEO_SAMSUNG_EXYNOS4_IS
>>   	bool "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
>>   	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
>> -	depends on (PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST)
>> +	depends on (ARCH_EXYNOS || COMPILE_TEST)
> 
>     Perhaps it's time to drop the useless parens?

Good point, let me prepare patches to clean that up.

--
Thanks,
Sylwester
