From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 1 Dec 2014 12:43:21 +0530
Subject: [PATCH v5 5/6] drivers: soc: exynos-pmu: Add support for Exynos7
In-Reply-To: <CADGdYn5SpruTdtjnC-BquBCt0fciFJi+5jXngvZ7wQ_xQLQc8w@mail.gmail.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
 <1417270508-11174-6-git-send-email-amit.daniel@samsung.com>
 <02b001d00c2d$27410aa0$75c31fe0$@kernel.org>
 <CADGdYn5SpruTdtjnC-BquBCt0fciFJi+5jXngvZ7wQ_xQLQc8w@mail.gmail.com>
Message-ID: <CAGcde9F84OP9Q7OX2p+x9a9M3EwiV-nQ1QzS0BzV8s_keLZ3KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 1 December 2014 at 09:59, amit daniel kachhap
<amit.daniel@samsung.com> wrote:
> On Sun, Nov 30, 2014 at 5:05 AM, Kukjin Kim <kgene@kernel.org> wrote:
>> Amit Daniel Kachhap wrote:
>>>
>>> Add PMU settings for exynos7. This is required for future suspend-to-ram,
>>> cpuidle and power domain support.
>>>
>>> Note: In this patch some static declarations lines are over 80
>>> characters per line for easy redability.
>>>
>>> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Eunseok Choi <es10.choi@samsung.com>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> ---
>>>  drivers/soc/samsung/exynos-pmu.c            |  427 ++++++++++++++++++++++++++-
>>>  include/linux/soc/samsung/exynos-regs-pmu.h |  273 +++++++++++++++++
>>>  2 files changed, 699 insertions(+), 1 deletion(-)
>>>
>> I'm not sure all of the definitions in exynos-regs-pmu are required?...too many,
>> and I couldn't check the addresses are correct ;)
> Actually i added the PMU power down for almost all the IP's of Exynos7
> as this is full system power down.
> I have taken care to add only used macros.
>>
>> And how about splitting to each SoC specific file in drivers/soc/samsung/ ?
>> For example, exynos-pmu.c and exynos7-pmu.c like cpufreq...? Just considering.
> Pankaj posted a patch which takes care of this.
>

It looks like something went wrong, I can't see my post on Samsung and
ARM mailing list, but it appeared on LKML. here is link for it..

https://lkml.org/lkml/2014/11/30/175

Thanks,
Pankaj Dubey

> Regards,
> Amit D.
>>
>> - Kukjin
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
