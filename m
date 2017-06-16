From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 16 Jun 2017 10:52:01 -0700
Subject: [PATCH 0/3] Meson (32-bit) multi_v7_defconfig updates
In-Reply-To: <888ef3fd-d8aa-d09c-dace-8662a7fd9c5a@baylibre.com> (Neil
 Armstrong's message of "Mon, 12 Jun 2017 09:38:15 +0200")
References: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
 <888ef3fd-d8aa-d09c-dace-8662a7fd9c5a@baylibre.com>
Message-ID: <m2r2yjg6ri.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 06/11/2017 12:03 PM, Martin Blumenstingl wrote:
>> This enables the following drivers which are supported on Meson8 and
>> Meson8b (as well as Meson8m2):
>> - Meson USB2 PHY driver (USB controller support is provided by dwc2,
>>   which is already enabled)
>> - Meson PWM driver (used to dim LEDs and generate the 32.768 kHz LPO
>>   clock for the SDIO wifi modules)
>> - the generic PWM clock driver (for the 32.768 kHz LPO clock for the
>>   SDIO wifi modules)
>> 
>> 
>> I am not sure if these patches will go through Kevin's Amlogic tree
>> or through some other tree. However, these should be independent from
>> anything else, so it's just a matter of preference through which tree
>> they go.
>> 
>> 
>> Martin Blumenstingl (3):
>>   ARM: multi_v7_defconfig: enable the Amlogic Meson USB2 PHY driver
>>   ARM: multi_v7_defconfig: enable the Meson PWM controller
>>   ARM: multi_v7_defconfig: enable the PWM clock driver
>> 
>>  arch/arm/configs/multi_v7_defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>
>
> Hi Martin,
>
> Isn't it better to have these as modules like for the ARM64 counterpart ?
>

+1  Please enable as modules wherever possible.

Thanks,

Kevin
