From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 1 Apr 2015 11:27:32 +0200
Subject: [PATCH v4 05/15] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <1427879123.3638.1.camel@pengutronix.de>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1427819096-31109-6-git-send-email-mcoquelin.stm32@gmail.com>
 <1427879123.3638.1.camel@pengutronix.de>
Message-ID: <CALszF6B5YUCtT2RPfFef_BjJhDmTbgkHO=V6C7ikUt2jRrWxBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

2015-04-01 11:05 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 31.03.2015, 18:24 +0200 schrieb Maxime Coquelin:
>> This adds documentation of device tree bindings for the
>> STM32 reset controller.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../devicetree/bindings/reset/st,stm32-rcc.txt     | 107 +++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> new file mode 100644
>> index 0000000..e2e2f25
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> @@ -0,0 +1,107 @@
>> +STMicroelectronics STM32 Peripheral Reset Controller
>> +====================================================
>> +
>> +The RCC IP is both a reset and a clock controller. This documentation only
>> +document the reset part.
>
> documents?
>
> Otherwise,
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

's' added for v5, and Acked-by applied.

Thanks,
Maxime

>
> regards
> Philipp
>
