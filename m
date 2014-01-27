From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 27 Jan 2014 11:06:47 +0200
Subject: [PATCH 2/4] ARM: dts: cm-fx6: add SATA support
In-Reply-To: <20140127073754.GB4765@S2101-09.ap.freescale.net>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
 <1390320812-25100-3-git-send-email-grinberg@compulab.co.il>
 <20140127073754.GB4765@S2101-09.ap.freescale.net>
Message-ID: <52E621A7.7030201@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/14 09:37, Shawn Guo wrote:
> On Tue, Jan 21, 2014 at 06:13:30PM +0200, Igor Grinberg wrote:
>> Enable SATA on cm-fx6.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
>> index 94cc6b5..07f90a5 100644
>> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
>> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
>> @@ -69,3 +69,7 @@
>>  	pinctrl-0 = <&pinctrl_uart4>;
>>  	status = "okay";
>>  };
>> +
>> +&sata {
>> +	status = "okay";
>> +};
> 
> Please sort these labeled nodes alphabetically.

Ok.

I'll wait for the "pingrp macros" to settle down and resend.

Thanks!

-- 
Regards,
Igor.
