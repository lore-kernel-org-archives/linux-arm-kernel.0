From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Mar 2014 12:23:16 +0100
Subject: [PATCH 2/2] ARM: clps711x: Switch CLPS711X subarch to use cpuidle
 driver
In-Reply-To: <1395832171.565939937@f148.i.mail.ru>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
 <1395467076-29462-2-git-send-email-shc_work@mail.ru>
 <5332B3F4.4010408@linaro.org> <1395832171.565939937@f148.i.mail.ru>
Message-ID: <5332B8A4.2010802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2014 12:09 PM, Alexander Shiyan wrote:
> Wed, 26 Mar 2014 12:03:16 +0100 ?? Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
>>> This patch removes old support for cpuidle and switches all current
>>> users to use new cpuidle driver.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>
>> Hi Alexander,
>>
>> this patch does not apply. Could you respin it against 3.14-rc8.
>
> This part (2/2) can be applied later, I can resend this one part through arm-soc tree.

Ok, I applied the patch 1/2 for 3.16 on my tree.

Thanks

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
