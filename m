From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Jul 2016 10:49:57 +0200
Subject: [PATCH 1/2] soc: samsung: Change type of PMU configuration
 register value to u32
In-Reply-To: <CAM4voan0X5ejdCAWwbRa-RtBsgpWHAFFex1soh153Zy8PdngRw@mail.gmail.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-2-git-send-email-a.kesavan@samsung.com>
 <CAJKOXPdPa7vCqetd5EUb3ebz7rB741ua=9wbdx-MkFh+G-=CJA@mail.gmail.com>
 <CAM4voan0X5ejdCAWwbRa-RtBsgpWHAFFex1soh153Zy8PdngRw@mail.gmail.com>
Message-ID: <5784AF35.9080302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 04:44 PM, Abhilash Kesavan wrote:
> Hi Krzysztof,
> 
> On Wed, Jul 6, 2016 at 8:47 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On Tue, Jul 5, 2016 at 10:28 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>>> Exynos7 has certain PMU registers that needs to be configured with
>>> u32 values.
>>>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> ---
>>>  drivers/soc/samsung/exynos-pmu.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
>>> index a469e36..1bdc506 100644
>>> --- a/drivers/soc/samsung/exynos-pmu.h
>>> +++ b/drivers/soc/samsung/exynos-pmu.h
>>> @@ -18,7 +18,7 @@
>>>
>>>  struct exynos_pmu_conf {
>>>         unsigned int offset;
>>> -       u8 val[NUM_SYS_POWERDOWN];
>>> +       unsigned int val[NUM_SYS_POWERDOWN];
>>
>> You mentioned u32 but I see unsigned int here. This should be u32.
> Will change.
>>
>> BTW, none of your emails reached my samsung inbox. I got them only
>> from the lists. Please investigate why this couldn't be delivered to
>> samsung.com address.
> 
> Not quite sure why that happened even after I added you as a
> recipient. I'll be posting some patches soon, let's see if the same
> occurs again or if it was a one-off case.

No problem with these mails so either this was one time issue or it was
caused by git-send-email and company's SMTP server.

Best regards,
Krzysztof
