From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 03 Jul 2013 01:27:31 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <51D2DA18.3020905@gmail.com> (Sebastian Hesselbarth's message of
 "Tue, 02 Jul 2013 15:48:08 +0200")
References: <87fvvzfh70.fsf@natisbad.org> <51D2DA18.3020905@gmail.com>
Message-ID: <87vc4stue4.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

>> +			pinctrl {
>> +				power_led_pin: power-led-pin {
>> +					marvell,pins = "mpp57";
>> +					marvell,function = "gpio";
>> +				};
>> +				sata1_led_pin: sata1-led-pin {
>> +					marvell,pins = "mpp15";
>> +					marvell,function = "gpio";
>> +				};
>> +
>> +				sata2_led_pin: sata2-led-pin {
>> +					marvell,pins = "mpp14";
>> +					marvell,function = "gpio";
>> +				};
>> +
>> +				backup_led_pin: backup-led-pin {
>> +					marvell,pins = "mpp56";
>> +					marvell,function = "gpio";
>> +				};
>> +			};
>> +
>> +			gpio_leds {
>
> Arnaud,
>
> gpio_leds, gpio_keys, and clocks nodes shouldn't be children of
> soc/internal-regs. I suggest to move them up as siblings of soc,
> memory, and chosen instead.

Will do that in next round. Thanks for pointing it.

Cheers,

a+
