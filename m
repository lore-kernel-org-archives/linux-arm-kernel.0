From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 18 Nov 2013 15:25:26 +0100
Subject: [PATCHv3] ASoC: Add support for BCM2835
In-Reply-To: <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
References: <5289F9DF.8060406@koalo.de>
 <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
Message-ID: <528A2356.4040501@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you!

>> diff --git a/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
>> new file mode 100644
>> index 0000000..7bf1d04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
>> @@ -0,0 +1,22 @@
>> +* Broadcom BCM2835 SoC I2S/PCM module
>> +
>> +Required properties:
>> +- compatible: "brcm,bcm2835-i2s"
>> +- reg: Register location and size
>> +       <PCM base address, size
>> +        PCM clock base address, size>;
> 
> []
> 
> Are the clocks actually a sub-block, or are they actually a separate
> unit that just happens to feed this one?

Sorry, but I don't get your point. It is a clock module that is
dedicated to the PCM module.
