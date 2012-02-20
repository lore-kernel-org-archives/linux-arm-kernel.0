From: joancarles@fqingenieria.es (joancarles)
Date: Mon, 20 Feb 2012 11:07:56 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220094013.GA9921@sapphire.tkos.co.il>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
Message-ID: <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch

Thanks for your reply.

>> We're trying to get our ADC working (actually generic 4-way
>> touchscreen support via ADC) on a custom PCB using the i.MX25
>> infrastructure. It seems that there are not a lot of people out
>> there, who have tried the Freescale implementation (based on their
>> latest kernel drop: 2.6.31) of the ADC driver for touchscreen
>> support. Freescale's support with regard to kernel development for
>> out-of-tree implementation, somewhat understandably, has so far been
>> close to non-existent.
>
> This list is for mainline kernel only. You should contact Freescale 
> for
> support for out of tree drivers in their kernel code. Unfortunately,
> it seems that Freescale has no interest in mainline kernel support 
> for i.MX25.

We have contacted them and all they support is their L2.6.13 freeze 
release for the i.MX25. It's actually even difficult to try to get in 
contact with anyone from their kernel development team. We anticipated 
that using our customized design based on an i.MX25, we'd run into these 
kind of issues.

> You may try a newer kernel drop from Freescale, based on 2.6.38 
> (tagged
> rel_imx_2.6.38_11.11.01). Get it from
> 
> http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary.

We have tried all "*rel*" tagged kernel of their repository, but they 
simply (especially touchscreen support) do not work. I wonder if anyone 
ever got the ADC touch screen support working at all with the i.MX25. We 
are also trying a stock 3.3-rc kernel and can't get our i.MX25 to boot 
... yet.

Best regards
-- 
Joan C. Abelaira
  FQ Ingenier?a Electr?nica, S.A.
Pol?gon Industrial Vilanoveta
Av. de les Roquetes, 9
E-08812 Sant Pere de Ribes (Barcelona)
SPAIN
Telf: +34 932 080 258
Fax: +34 934 592 893
M?vil: +34 638 331 745

http://www.fqingenieria.es/
email: joancarles at fqingenieria.es
