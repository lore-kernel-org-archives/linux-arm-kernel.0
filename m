From: dh09.lee@samsung.com (Donghwa Lee)
Date: Fri, 04 Mar 2011 13:41:31 +0900
Subject: [PATCH] ARM: EXYNOS4: enabled lcd and backlight in NURI board
In-Reply-To: <01ad01cbd961$40e69720$c2b3c560$%kim@samsung.com>
References: <1299028671-9062-1-git-send-email-dh09.lee@samsung.com>
	<01ad01cbd961$40e69720$c2b3c560$%kim@samsung.com>
Message-ID: <4D706D7B.8020009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 2011-03-03, Kukjin Kim wrote:
>
>>  #
>>  # Display device support
>> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
>> index 5bf00b9..1d0d222 100644
>> --- a/arch/arm/mach-exynos4/Kconfig
>> +++ b/arch/arm/mach-exynos4/Kconfig
>> @@ -135,6 +135,7 @@ config MACH_NURI
>>  	select EXYNOS4_SETUP_I2C1
>>  	select EXYNOS4_SETUP_I2C5
>>  	select EXYNOS4_SETUP_SDHCI
>> +	select HAVE_PWM
> Since Banajit's PWM backlight patches will be merged, should be following
> your next patch.
>
> +	select SAMSUNG_DEV_PWM
>
>

Dear Kukjin,
Thanks for your review.
I'm preparing next patch for your review including other modifications.
But, I cannot find committed patches of PWM backlight of Banajit.
Was it merged? If so, please tell me committed tree.

Thank you,
Donghwa Lee
