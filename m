From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 10 Nov 2013 01:50:48 +0100
Subject: [PATCH] ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554
 I2C to GPIO muxer
In-Reply-To: <527ECC4C.8080207@gmail.com> (Sebastian Hesselbarth's message of
 "Sun, 10 Nov 2013 00:59:08 +0100")
References: <877gchmggw.fsf@natisbad.org> <527ECC4C.8080207@gmail.com>
Message-ID: <87d2m9uljr.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

>> +
>> +		sata1_led {
>> +			label = "rn104:blue:sata1";
>> +			gpios = <&pca9554 0 1>;  /* Active Low */
>
> Same comment as for ReadyNAS 2120 patch:
>
> #include <dt-bindings/gpio/gpio.h> and use GPIO_ACTIVE_HIGH/LOW.
>
> Sebastian

Will fix that and resend tomorrow.

Cheers,

a+
