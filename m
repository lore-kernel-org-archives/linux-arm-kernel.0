From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 06 May 2015 06:40:57 +0900
Subject: [RESEND-PATCH] ARM: dts: Add missing irq pinctrl for max77686
 on smdk5250
In-Reply-To: <CAJKOXPd2x_DiD8EAq202=scTuK0HHH8evvD_TkLn4oO_6hrRhg@mail.gmail.com>
References: <1430798855-27271-1-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPd2x_DiD8EAq202=scTuK0HHH8evvD_TkLn4oO_6hrRhg@mail.gmail.com>
Message-ID: <554938E9.10907@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/15 13:14, Krzysztof Koz?owski wrote:
> 2015-05-05 13:07 GMT+09:00 Pankaj Dubey <pankaj.dubey@samsung.com>:
>> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>>
>> This patch adds pinctrl configuration for using configuring gpx3-2 as an
>> external interrupt from max77686. Though max77686 RTC is enabled and gets
>> probed by default, it doesnt work as its unable to get interrupt.
>>
>> This patch makes max77686 RTC work and also configures it as wakeup source.
>>
>> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>
>> Initial version of this patch was part of following series, though
>> they are not dependent on each other, resubmitting after rebasing
>> and detaching second one from first patch in the series [1]
>>
>> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303652.html
> 
> Thanks, but now it needs your Signed-off-by because you touched it.
> 
Just note, to more clarify, Signed-off-by should be added who wants to
submit anything into mailing-list even no updating and just posting...

> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
Thanks,
Kukjin
