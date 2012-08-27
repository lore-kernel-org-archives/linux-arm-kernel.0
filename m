From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Aug 2012 16:46:58 -0300
Subject: [PATCH 1/3] ARM: mx28evk: Add SPI flash support
In-Reply-To: <201208271858.16842.marex@denx.de>
References: <1346084609-31407-1-git-send-email-fabio.estevam@freescale.com>
 <201208271858.16842.marex@denx.de>
Message-ID: <CAOMZO5BfPnFXShGQx7eB1JcTfq39j_4iDsdd-heLBdsDfF7WJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 1:58 PM, Marek Vasut <marex@denx.de> wrote:

>> +                     ssp2: ssp at 80014000 {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             compatible = "fsl,imx28-spi";
>> +                             pinctrl-names = "default";
>> +                             pinctrl-0 = <&spi2_pins_a>;
>> +                             status = "okay";
>> +
>> +                             flash: m25p80 at 0 {
>
> Shouldn't this also be sst25vf016b at 0 ?

The alias is still m25p80 in this case.

Regards,

Fabio Estevam
