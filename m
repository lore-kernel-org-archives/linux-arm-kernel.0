From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Wed, 07 Dec 2011 01:26:51 +0200
Subject: [PATCH resend2] s3c24xx: cpufreq: Fix compilation error when
 CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
In-Reply-To: <02ef01ccb40a$9078f2e0$b16ad8a0$%kim@samsung.com>
References: <4EDD720B.5040607@solonet.org.ua>
 <02ef01ccb40a$9078f2e0$b16ad8a0$%kim@samsung.com>
Message-ID: <4EDEA4BB.60807@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2011 01:31 PM, Kukjin Kim wrote:
> Denis Kuzmenko wrote:
>>
>> Fix compilation error when CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
>>
>> Signed-off-by: Denis Kuzmenko <linux@solonet.org.ua>
>> ---
>>
>> Patch is against 3.2-rc3.
>> CONFIG_S3C2410_IOTIMING wasn't present in Kconfig but was referenced by
>> Makefile. Because of this the file s3c2410-iotiming.c was not ever
>> compiled
> 
> Well, there is 'S3C2410_IOTIMING' at arch/arm/plat-s3c24xx/Kconfig and it
> had dependency of 'CONFIG_CPU_FREQ_S3C24XX'...
> 

Yeah, I've missed that, thank you. I'll make a new version.

-- 
Best regards, Denis Kuzmenko.
