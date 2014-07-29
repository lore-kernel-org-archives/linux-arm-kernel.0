From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 29 Jul 2014 14:11:09 +0200
Subject: [PATCH v8 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
In-Reply-To: <CAJuA9ahgOS7ccqiaMHn9rTS4tY3ah64rzbmQugWmL3s6HXFZVQ@mail.gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>	<1406611711-25112-7-git-send-email-thomas.ab@samsung.com>	<53D77B01.40702@gmail.com>
 <CAJuA9ahgOS7ccqiaMHn9rTS4tY3ah64rzbmQugWmL3s6HXFZVQ@mail.gmail.com>
Message-ID: <53D78F5D.60500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.07.2014 14:04, Thomas Abraham wrote:
> Hi Tomasz,
> 
> On Tue, Jul 29, 2014 at 4:14 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Thomas,
>>
>> You can find few comments inline.
>>
>> On 29.07.2014 07:28, Thomas Abraham wrote:
>>
>> [snip]
>>
>>> @@ -714,15 +715,24 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>>                                                         ^^^
>>
>> Keep in mind that following clocks are common for Exynos4210 and
>> Exynos4x12. Have you tested this series on a board based on Exynos4212
>> or 4412 to verify that it does not break the legacy driver? (I would
>> test it myself, but I am on holidays at the moment.)
> 
> Thanks for taking time to have a look at this series. I have tested
> this series with the old cpufreq driver for Exynos4412 on an
> Origen4412 board and it works fine. These divider clocks are not
> directly used or referenced by the legacy cpufreq driver. So I marked
> them as read-only here.

OK.

Best regards,
Tomasz
