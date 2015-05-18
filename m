From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 18 May 2015 14:09:08 +0200
Subject: [PATCH v4 2/7] clocksource: add lpc32xx timer driver
In-Reply-To: <2239410.eaKNvGFUP4@wuerfel>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-3-git-send-email-manabian@gmail.com>
 <2239410.eaKNvGFUP4@wuerfel>
Message-ID: <5559D664.7000308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2015 10:01 PM, Arnd Bergmann wrote:
> On Tuesday 12 May 2015 00:00:48 Joachim Eastwood wrote:
>> Add support for using the NXP LPC timer as clocksource and clock
>> event. These timers are present on many NXP devices including
>> LPC32xx, LPC17xx, LPC18xx and LPC43xx.
>>
>> The timer has a 32-bit timer counter register with a programmable
>> 32-bit prescaler. It supports up to 4 compare match values with
>> interrupt generation and reset/stop timer counter action.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>
>
> Looks ok to me, please merge this and patch 3 through the clocksource tree.
>
> 	Arnd
>

Applied to my tree for 4.2.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
