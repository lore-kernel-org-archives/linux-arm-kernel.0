From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 13:47:37 +0900
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <4E7FE0A4.4050105@cn.fujitsu.com>
References: <5525949.50001316849744994.JavaMail.weblogic@epml24>
	<20110924093851.GB17169@n2100.arm.linux.org.uk>
	<CAHQjnOPMRQetGF5VnwsMD=_JxWC5C-LQ5WRyZhPs2HtCzis2Tg@mail.gmail.com>
	<4E7FE0A4.4050105@cn.fujitsu.com>
Message-ID: <CAHQjnOMAdkf6FUcVsr74zWM9Vij-5nduZWK+pa2MQC8KJUjRtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks. I will try.

Regards,
Cho KyongHo.

On Mon, Sep 26, 2011 at 11:17 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 09/26/2011 08:44 AM, KyongHo Cho wrote:
>
>> Hi.
>>
>> On Sat, Sep 24, 2011 at 6:38 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Sat, Sep 24, 2011 at 07:35:45AM +0000, ??? wrote:
>>>> +# EXYNOS IOMMU support
>>>> +config EXYNOS_IOMMU
>>>> + bool "Exynos IOMMU Support"
>>>> + depends on ARCH_EXYNOS4
>>>> + select IOMMU_API
>>>> + select EXYNOS4_DEV_SYSMMU
>>>> + help
>>>
>>> Looks like your mailer converted tabs to one space. ?This makes it more
>>> difficult to read this patch as a whole. ?Don't expect good reviews as
>>> long as your mailer breaks stuff in this way.
>> Sorry for that :(
>> I will try another way to send patches correctly.
>
>
> Use *git send-email* instead.
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
