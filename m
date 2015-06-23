From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 23 Jun 2015 11:24:26 +0200
Subject: [PATCH v3 0/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <55891729.7070809@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
 <20150622224832.GI22132@codeaurora.org>
 <55891729.7070809@linaro.org>
Message-ID: <CALszF6Dw7hWATpjVvpxmitKWSJ458JXWOZFXMjudcW_jaNiZdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-23 10:22 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 22/06/15 23:48, Stephen Boyd wrote:
>>
>> On 06/10, Daniel Thompson wrote:
>>>
>>> This patchset implements a clock driver for STM32F42xxx and STM32F43xxx
>>> series devices. It supports decoding the state configured by the
>>> bootloader (PLL, clock select, bus dividers) and all the gates clocks.
>>> It does not currently support the I2S and SAI PLLs.
>>>
>>> Relies on "Add support to STMicroeletronics STM32 family" v9 by Maxime
>>> Coquelin: http://thread.gmane.org/gmane.linux.kernel/1961049 .
>>>
>>
>> I applied 1 and 2. Looks like #3 should go through arm-soc at
>> some later time?
>
>
> Agreed (that is also the patch that must be correctly ordered w.r.t.
> Maxime's patches).

Indeed, I will take care of patch 3.

Thanks,
Maxime
