From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Tue, 30 Oct 2012 11:23:26 +0530
Subject: [PATCH v2 1/2] ARM: exynos4: Add devicetree node for TMU driver
In-Reply-To: <508E74FE.7090900@samsung.com>
References: <1351243746-4173-1-git-send-email-amit.daniel@samsung.com>
 <1351243746-4173-2-git-send-email-amit.daniel@samsung.com>
 <508E74FE.7090900@samsung.com>
Message-ID: <CAK44p21udhZWexYkCmoFv_rPdYb0HYd1wxw1gpOQb69_OE2LGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2012 17:52, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 10/26/12 18:29, Amit Daniel Kachhap wrote:
>>
>> From: Amit Daniel Kachhap<amit.daniel@samsung.com>
>>
>> This patch adds necessary source definations needed for TMU driver and
>> adds devicetree node for exynos4210.
>>
>> Signed-off-by: Amit Daniel Kachhap<amit.daniel@samsung.com>
>> ---
>
>
> [...]
>
>
>> +               .name           = "tmu_apbif",
>> +               .enable         = exynos4_clk_ip_perir_ctrl,
>> +               .ctrlbit        = (1<<  17),
>
>
> tab instead of white spaces?
>
> I fixed them when I applied.
Thanks Mr Kim.
>
> [...]
>
>
>> +#define EXYNOS4_IRQ_TMU_TRIG0          COMBINER_IRQ(2, 4)
>> +#define EXYNOS4_IRQ_TMU_TRIG1          COMBINER_IRQ(3, 4)
>
>
> BTW, where are above definitions used?

They are not used currently but might be useful for non DT support.

Thanks,
Amit Daniel
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
