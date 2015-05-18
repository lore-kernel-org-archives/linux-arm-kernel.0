From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 18 May 2015 14:49:26 +0200
Subject: [PATCH v8 04/16] clocksource/drivers: Add ARM System timer driver
In-Reply-To: <CALszF6BiKwDKejfpVgs6ojTxC4LSRfLSEaszXTGVy7xfbHLHZg@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<1431158038-3813-5-git-send-email-mcoquelin.stm32@gmail.com>
 <CALszF6BiKwDKejfpVgs6ojTxC4LSRfLSEaszXTGVy7xfbHLHZg@mail.gmail.com>
Message-ID: <5559DFD6.3050603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2015 01:55 PM, Maxime Coquelin wrote:
> Hi Daniel,
>
> 2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
>> This patch adds clocksource support for ARMv7-M's System timer,
>> also known as SysTick.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>   drivers/clocksource/Kconfig          |  7 ++++
>>   drivers/clocksource/Makefile         |  1 +
>>   drivers/clocksource/armv7m_systick.c | 79 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 87 insertions(+)
>>   create mode 100644 drivers/clocksource/armv7m_systick.c
>>
>
> Could you consider applying this patch and its dt-bindings
> documentation (patch 3/16) on your tree for v4.2?

Patches applied for 4.2.

Thanks

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
