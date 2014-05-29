From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Thu, 29 May 2014 15:36:10 +0200
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <7hr43f9mmn.fsf@paris.lan>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan>
Message-ID: <538737CA.4070709@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek and Kevin,

Am 27.05.2014 19:06, schrieb Kevin Hilman:
> Tarek Dakhran <t.dakhran@samsung.com> writes:
> 
>> The series of patches represent support of Exynos 5410 SoC
>>
>> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
>>
>> Patches add new platform description, support of clock controller and device
>> tree for Exynos 5410.
>>
>> Has been build on Samsung Linux Kernel
>>   (branch: for-next, commit: 97eae6c Merge branch 'v3.16-next/multiplatform' into for-next)
>>
>> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
>> 		    2) Exynos 5410 reference board (multi_v7_defconfig)
>> 		    3) Odroid-XU board (exynos_defconfig)
>> 		    4) Odroid-XU board (multi_v7_defconfig)
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> FYI, I boot tested this on an odroid-xu (exynos_defconfig and
> multi_v7_defconfig.)

Could you clarify: Are you using exynos5410-smdk5410.dts with the
ODROID-XU or do you have some upcoming exynos5410-odroidxu.dts based on
exynos5410.dtsi?

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
