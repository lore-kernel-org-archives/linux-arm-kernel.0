From: r.sh.open@gmail.com (Rahul Sharma)
Date: Wed, 9 Apr 2014 14:45:50 +0530
Subject: [PATCH v7 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <53450D29.7020207@samsung.com>
References: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
 <1396519224-18712-2-git-send-email-rahul.sharma@samsung.com>
 <CAK9yfHzuVZh-RhfT+0tEehnF+aWnYHG=X2cv_E6uvzq2aS7UQg@mail.gmail.com>
 <53450D29.7020207@samsung.com>
Message-ID: <CAPdUM4OitgCTOT4Eo2Uq-UW95Z1D7yoLrqC_=+==tPAg8kJBtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2014 14:34, Tomasz Figa <t.figa@samsung.com> wrote:
> On 07.04.2014 10:38, Sachin Kamat wrote:
>>
>> Hi Rahul,
>>
>> On 3 April 2014 15:30, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>>
>>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>
>>> This patch add basic arch side support for exynos5260 SoC.
>>
>> <snip>
>>
>>> @@ -374,6 +374,7 @@ static char const *exynos_dt_compat[] __initconst = {
>>>          "samsung,exynos4412",
>>>          "samsung,exynos5",
>>>          "samsung,exynos5250",
>>> +       "samsung,exynos5260",
>>
>>
>> I don't think we should be adding this as we do not yet have any soc
>> specific quirk.
>> Compatibility to generic string, "samsung,exynos5"  should be sufficient.
>>
>
> Yes. Unless a SoC specific quirk that needs to be handled at such low level
> stage emerges, there is no need to add such compatible string to the kernel.
>

Thanks Sachin, Tomasz,

I will change this.

Regards,
Rahul Sharma.

> Best regards,
> Tomasz
