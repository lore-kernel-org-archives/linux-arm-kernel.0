From: amit.kachhap@gmail.com (amit kachhap)
Date: Sat, 14 Jul 2012 12:55:14 +0530
Subject: [PATCH 0/2] ARM: exynos: Enable TMU support in exynos platforms
In-Reply-To: <20120713144138.GB25264@roeck-us.net>
References: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
 <117e01cd60ea$99f24e60$cdd6eb20$%kim@samsung.com>
 <20120713144138.GB25264@roeck-us.net>
Message-ID: <CADGdYn5mrHVBEhYF-Zv1UJK1YtVNk=kBA98xOdWevRU+_tu6cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 8:11 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Jul 13, 2012 at 08:28:18PM +0900, Kukjin Kim wrote:
>> Amit Daniel Kachhap wrote:
>> >
>> > These TMU enablement patches are needed for exynos4 and exynos5 TMU
>> > driver patches sent earlier. The link for those are
>> > http://www.spinics.net/lists/lm-sensors/msg35858.html.
>> >
>> How was going on above patches? I can't see them you said in linux-next now,
>> it means if I apply this series in my tree, problem will be happened :(
>>
>> Note1: I've seen Rafael's updating exynos4_tmu patch which is using struct
>> dev_pm_ops for pm and applied by Guenter.
>>
> If that is in the way, I can drop it, to be applied after the move. Let me know.
> There is now another patch pending, to convert the driver to use devm_ functions.
> Please let me know what you want me to do with it.
>
Hi Guenter,

I rebased my V5 patch series with  hwmon-next branch so Rafael's pm
changes are already included. Regarding the devm_ patch by sachin
please hold it.

Thanks,
Amit D
>> Note2: would be helpful if you could do adding me in Cc of exynos tmu
>> patches...
>>
> If you want to be copied, it might make sense to add yourself as maintainer for
> this file. Otherwise you can not expect people to know.
>
> Thanks,
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
