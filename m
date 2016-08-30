From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Aug 2016 12:15:59 +0200
Subject: [PATCH 1/3] clocksource/drivers/timer-atmel-pit: Enable mck clock
In-Reply-To: <20160830095555.GB1223@leverpostej>
References: <57C05026.7010905@linaro.org>
 <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
 <20160830095555.GB1223@leverpostej>
Message-ID: <57C55CDF.7030504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2016 11:55 AM, Mark Rutland wrote:
> Hi,
> 
> On Fri, Aug 26, 2016 at 04:20:43PM +0200, Daniel Lezcano wrote:
>> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> mck is needed to get the PIT working. Explicitly prepare_enable it instead
>> of assuming it is enabled.
>>
>> This solves an issue where the system is freezing when the ETM/ETB drivers
>> are enabled.
>>
>> Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

Hi Mark,

It is fixed.

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/urgent&id=98744b408c757901df57fa50cbd5826245dc3a1f

Thanks for reporting the issue and for the fix.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
