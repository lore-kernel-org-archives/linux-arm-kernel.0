From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Apr 2013 14:46:33 +0530
Subject: [PATCH V6 1/4] cpufreq: exynos: Add cpufreq driver for exynos5440
In-Reply-To: <CAKohpo=CFTo2UCnECeeuKdz34cuedV_tqn7zGA9bzU_PiJ46qg@mail.gmail.com>
References: <1365409058-32643-1-git-send-email-amit.daniel@samsung.com>
 <1365409058-32643-2-git-send-email-amit.daniel@samsung.com>
 <CAKohpo=CFTo2UCnECeeuKdz34cuedV_tqn7zGA9bzU_PiJ46qg@mail.gmail.com>
Message-ID: <CAKohpo=t_YTCTRCfnwQ+GPF=frsTGDigT3RZHJuVQ+R+YZU7Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2013 14:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 April 2013 13:47, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index f3f3b14..bce2195 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -42,6 +42,15 @@ config ARM_EXYNOS5250_CPUFREQ
>>           This adds the CPUFreq driver for Samsung EXYNOS5250
>>           SoC.
>>
>> +config ARM_EXYNOS5440_CPUFREQ
>> +       def_bool SOC_EXYNOS5440
>> +       depends on HAVE_CLK && PM_OPP && OF
>
> Don't you need a depend on your Soc or mach or arch? Don't send another
> version for this now.. Just send a new patch over this patchset.

Sorry, i overlooked def_bool... This comments stands invalid.
