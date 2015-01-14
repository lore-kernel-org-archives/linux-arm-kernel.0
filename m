From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 14 Jan 2015 10:48:21 +0800
Subject: [PATCH v2 0/8] ARM: at91: dts: sama5d3: add dt support for atmel
 isi and ov2640 sensor
In-Reply-To: <54B53455.9050407@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
 <54B53455.9050407@atmel.com>
Message-ID: <54B5D8F5.6000800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/13/2015 11:05 PM, Nicolas Ferre wrote:
> Le 04/01/2015 10:02, Josh Wu a ?crit :
>> This patch series add ISI and ov2640 support on dts files.
>>
>> As the ov2640 driver dt is still in review. The patch is in: https://patchwork.linuxtv.org/patch/27554/
>> So I want to send this dt patch early for a review.
>>
>> v1 -> v2:
>>    1. add one more patch to change the pin name of ISI_MCK
>>    2. rewrite the commit [4/8] ARM: at91: dts: sama5d3: change name of pinctrl_isi_{power,reset}.
>>    3. move the common chip parts of ISI node to sama5d3.dtsi.
>>
>> Bo Shen (3):
>>    ARM: at91: dts: sama5d3: split isi pinctrl
>>    ARM: at91: dts: sama5d3: add missing pins of isi
>>    ARM: at91: dts: sama5d3: move the isi mck pin to mb
>>
>> Josh Wu (5):
>>    ARM: at91: dts: sama5d3: add isi clock
>>    ARM: at91: dts: sama5d3: change name of pinctrl_isi_{power,reset}
>>    ARM: at91: dts: sama5d3: change name of pinctrl of ISI_MCK
>>    ARM: at91: dts: sama5d3: add ov2640 camera sensor support
>>    ARM: at91: sama5: enable atmel-isi and ov2640 in defconfig
> Josh,
>
> It seems that this patch doesn't show up in the series: I only received
> up to 6/8 patches (2 missing?). Can you please send it(them?)?

Thanks you, Nicolas. I am not aware that.
I just sent out the missing 7/8, 8/8 patches right now.

Best Regards,
Josh Wu

>
> Bye,
>
>>   arch/arm/boot/dts/sama5d3.dtsi    | 24 ++++++++++++++++++-----
>>   arch/arm/boot/dts/sama5d3xmb.dtsi | 40 +++++++++++++++++++++++++++++++++++----
>>   arch/arm/configs/sama5_defconfig  |  6 ++++++
>>   3 files changed, 61 insertions(+), 9 deletions(-)
>>
>
