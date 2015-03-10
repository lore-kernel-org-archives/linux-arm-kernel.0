From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 10 Mar 2015 16:45:59 +0100
Subject: [PATCH v2 12/18] dt-bindings: Document the STM32 USART bindings
In-Reply-To: <38153432.AWA0ogMaoK@wuerfel>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-13-git-send-email-mcoquelin.stm32@gmail.com>
 <38153432.AWA0ogMaoK@wuerfel>
Message-ID: <CALszF6BEYTAF9FiQQB9wF74btVbaMYPgSTRz41-LbhDUnY_37w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-10 16:08 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 20 February 2015 19:01:11 Maxime Coquelin wrote:
>> +
>> +Example:
>> +usart1: usart at 40011000 {
>> +       compatible = "st,stm32-usart";
>>
>
> Please use generic node names everywhere. The standard name for a serial
> port is "serial".

I already had the remark, and it is already fixed in the next version.

Thanks,
Maxime

>
>         Arnd
