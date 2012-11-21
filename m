From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 21 Nov 2012 09:43:33 +0800
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <20121120102712.GF10560@opensource.wolfsonmicro.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
 <20121116064113.GQ4387@opensource.wolfsonmicro.com>
 <50A5E44D.6040501@atmel.com> <50AB4DEA.3090100@atmel.com>
 <20121120102712.GF10560@opensource.wolfsonmicro.com>
Message-ID: <50AC31C5.2000504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/20/2012 18:27, Mark Brown wrote:
> On Tue, Nov 20, 2012 at 05:31:22PM +0800, Bo Shen wrote:
>
>>> based on ASoC tree? And the upper go into pinctrl tree?
>>> ---<8---
>>> ssc0: ssc at fffbc000 {
>>>      compatible = "atmel,at91rm9200-ssc";
>>>          reg = <0xfffbc000 0x4000>;
>>>          interrupts = <14 4 5>;
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
>>>          status = "disable";
>>> };
>>> --->8---
>
>> Any suggestion for this? what should I do with this patch for next?
>
> Send it to pinctrl and we'll deal with the add/add.

So, should I keep these two patches [1] and [2] and then send to pinctrl 
again, or I need keep it in one patch as [3] which i sent first.

1. [Resend,v6,1/2] ARM: at91: atmel-ssc: add pinctrl nodes
    https://patchwork.kernel.org/patch/1753101/

2. [Resend,v6,2/2] ASoC: atmel-ssc: add pinctrl consumer
    https://patchwork.kernel.org/patch/1753091/

3. [v6,1/4] ARM: at91: atmel-ssc: add pinctrl support
    https://patchwork.kernel.org/patch/1740391/

Best regards,
Bo Shen
