From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Fri, 28 Jan 2011 23:18:21 +0900
Subject: [PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
In-Reply-To: <02e001cbbecd$b9aee0d0$2d0ca270$%kim@samsung.com>
References: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
	<1294419468-13700-2-git-send-email-s.nawrocki@samsung.com>
	<02e001cbbecd$b9aee0d0$2d0ca270$%kim@samsung.com>
Message-ID: <4D42D02D.2070601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 01/28/2011 06:28 PM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> Add I2C0 bus platform device for camera sensors.
>>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
>>   arch/arm/mach-s5pv210/Kconfig     |    1 +
>>   arch/arm/mach-s5pv210/mach-goni.c |    4 ++++
>>   2 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>> index 53aabef..b0aa462 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -75,6 +75,7 @@ config MACH_GONI
>>   	bool "GONI"
>>   	select CPU_S5PV210
>>   	select S5P_GPIO_INT
>> +	select S3C_DEV_I2C0
>
> NO...Where is S3C_DEV_I2C0?
> Basically, platform device of i2c0 which is in
> arch/arm/plat-samsung/dev-i2c0.c is always selected.

Oh, sorry about that omission. I'll resend that one corrected.

Thanks,
Sylwester
