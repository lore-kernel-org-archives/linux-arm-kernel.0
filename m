From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 14:07:15 +0100
Subject: [PATCH v2 0/2] ARM: at91: dt: at91sam9n12ek: enable udp device
In-Reply-To: <54F42E12.4010808@atmel.com>
References: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
 <54F42E12.4010808@atmel.com>
Message-ID: <54F70383.1030707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/03/2015 10:32, Bo Shen a ?crit :
> Hi Nicolas,
> 
> On 02/10/2015 09:55 AM, Bo Shen wrote:
>> This patch series enable usb device support on at91sam9n12ek board.
>>
>> Changes in v2:
>>    - Base on next-20150209 (so, remove the modification of udc driver).
>>    - Add pinctrl for usb1 vbus sense.
>>
>> Bo Shen (2):
>>    ARM: at91: dt: at91sam9n12: add udp device node
>>    ARM: at91: dt: at91sam9n12ek: enable udp
> 
> Any comments for this patch series? (aka ping?)

Hi,

For the 2 patches:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And I've just taken these 2 patches on top of the at91-4.1-dt branch.

Thanks for the "heads up" !

Bye,

>>   arch/arm/boot/dts/at91sam9n12.dtsi  |  9 +++++++++
>>   arch/arm/boot/dts/at91sam9n12ek.dts | 14 ++++++++++++++
>>   2 files changed, 23 insertions(+)
>>
> 
> Best Regards,
> Bo Shen
> 


-- 
Nicolas Ferre
