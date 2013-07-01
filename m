From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 01 Jul 2013 22:31:54 +0200
Subject: [PATCH] arm: kirkwood: readynas duo v2: Add GMT G762 Fan
 Controller DT bindings
In-Reply-To: <20130701222814.36ca395a@skate> (Thomas Petazzoni's message of
 "Mon, 1 Jul 2013 22:28:14 +0200")
References: <87sizyuj0t.fsf@natisbad.org> <20130701222814.36ca395a@skate>
Message-ID: <87k3lauimd.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Mon, 01 Jul 2013 22:23:14 +0200, Arnaud Ebalard wrote:
>
>> -        regulators {
>> -                compatible = "simple-bus";
>> -                #address-cells = <1>;
>> -                #size-cells = <0>;
>> -
>> -                usb_power: regulator at 1 {
>> -                        compatible = "regulator-fixed";
>> -                        reg = <1>;
>> -                        regulator-name = "USB 3.0 Power";
>> -                        regulator-min-microvolt = <5000000>;
>> -                        regulator-max-microvolt = <5000000>;
>> -                        enable-active-high;
>> -                        regulator-always-on;
>> -                        regulator-boot-on;
>> -                        gpio = <&gpio1 14 0>;
>> -                };
>> -        };
>> +	regulators {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usb_power: regulator at 1 {
>> +			compatible = "regulator-fixed";
>> +			reg = <1>;
>> +			regulator-name = "USB 3.0 Power";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			enable-active-high;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +			gpio = <&gpio1 14 0>;
>> +		};
>> +	};
>>  };
>
> Those white-space changes are not related to the addition of the G762
> Device Tree informations.

Should I make two unrelated patches (one for G762 and another cosmetic
one) or simply let the spaces as they are in .dts?

Cheers,

a+
