From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu, 19 Jun 2014 09:43:48 +0530
Subject: [PATCH v6 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <CAKohpomt4M_V7rMAoh=+UFon3CxnZjVY_9DuVtQW9ddtTTj7Fg@mail.gmail.com>
References: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
 <CAKohpomt4M_V7rMAoh=+UFon3CxnZjVY_9DuVtQW9ddtTTj7Fg@mail.gmail.com>
Message-ID: <CAJuA9ajzUTRL7An-BGEAro7cyFO8YXQnBVPBx7LyOd-tLGuc1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 1:21 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 June 2014 20:55, Thomas Abraham <thomas.ab@samsung.com> wrote:
>> Changes since v5:
>> - Configuration data for cpu clock block is embedded with the code. The cpu clock
>>   logic can later to extended to obtain this data from DT.
>> - Excluded the support for Exynos4x12 SoC since the work on boost OPP bindings is
>>   still incomplete.
>> - Included cpufreq support for Exynos5420 SoC.
>> - Many other minor changes (and so dropped Ack's for some of the patches in v5)
>>
>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>> series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
>> driver.
>
> cpufreq at vger.kernel.org list is deprecated now: dec102a, use linux-pm instead.

Ok. Will take care next time.

>
> For patch 5 and 6:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks Viresh.

Regards,
Thomas.

> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
