From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2018 10:46:28 -0300
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
In-Reply-To: <20180611052608.GB16091@dragon>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
 <20180611052608.GB16091@dragon>
Message-ID: <CAOMZO5AHbPOS_3ShrMAoiXMxRWR6M16khDZM_9V4mRxM2MbnGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jun 11, 2018 at 2:26 AM, Shawn Guo <shawnguo@kernel.org> wrote:

>> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> index 0c99ac04ad08..98cc107098e0 100644
>> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> @@ -581,6 +581,14 @@
>>               watchdog {
>>                       compatible = "zii,rave-sp-watchdog";
>>               };
>> +
>> +             backlight {
>> +                     compatible = "zii,rave-sp-backlight";
>> +             };
>> +
>> +             pwrbutton {
>> +                     compatible = "zii,rave-sp-pwrbutton";
>> +             };
>
> Where are these compatibles documented?

Currently they are documented in linux-next at:

Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt

They should land in 4.18-rc1.
