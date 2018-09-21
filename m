From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 13:05:04 +0200
Subject: [PATCH v2] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <87tvn24q2b.fsf@tkos.co.il> (Baruch Siach's message of "Thu, 06
 Sep 2018 18:13:16 +0300")
References: <a8f5114101ac62622a8b8152ba5415f39e52f05b.1536232787.git.baruch@tkos.co.il>
 <20180906125300.GA22121@lunn.ch> <87tvn24q2b.fsf@tkos.co.il>
Message-ID: <87h8iji00v.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On jeu., sept. 06 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Andrew,
>
> Andrew Lunn writes:
>>> v2:
>>>   * Add SATA node
>>>
>>>   * Set front button code to KEY_WPS_BUTTON
>>>
>>>   * Use LEDs labels more aligned to conversion
>>
>> Hi Baruch
>>
>> It would be good to say why you did not make it fully aligned to
>> convention. What is wrong with "clearfog-gt-8k:green:led0"
>
> I wasn't sure what the 'devicename' field translates to for on-board
> LEDs. The leds-class.txt document recommends to leave blank
> non-applicable fields. Existing DTs already have have labels like
> "beaglebone:green:usr0", and "am3517evm:green:user_led_1". So I'm fine
> with your suggestion.

If you send a new version with this change than I will apply it on the
mvebu trees.

Thanks,

Gregory

>
>>> +		mdio {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			switch0phy0: switch0phy0 at 11 {
>>> +				reg = <0x11>;
>>> +			};
>>> +			switch0phy1: switch0phy1 at 12 {
>>> +				reg = <0x12>;
>>> +			};
>>> +			switch0phy2: switch0phy2 at 13 {
>>> +				reg = <0x13>;
>>> +			};
>>> +			switch0phy3: switch0phy3 at 14 {
>>> +				reg = <0x14>;
>>> +			};
>>> +		};
>>
>> It would be nice to add a black line after each child node.
>>
>> Otherwise, this looks good.
>
> Thanks for reviewing.
>
> baruch
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
