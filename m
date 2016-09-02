From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Sep 2016 05:01:57 -0500
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
In-Reply-To: <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
Message-ID: <d3df6f32-1294-17bc-8b5f-236d14a349a0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2016 04:58 AM, Tomi Valkeinen wrote:
> On 02/09/16 12:06, Nishanth Menon wrote:
>
>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>> new file mode 100644
>> index 000000000000..da61dbba7768
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Copyright (C) 2014-2016 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "am57xx-beagle-x15-common.dtsi"
>> +
>> +/ {
>> +	model = "TI AM5728 BeagleBoard-X15 rev B1";
>> +};
>> +
>> +&tpd12s015 {
>> +	gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
>> +		<&gpio2 30 GPIO_ACTIVE_HIGH>,	/* gpio6_30, LS OE */
>
> Wrong gpio in the comment.

Uggh.. thanks for catching that.. should have been gpio2_30

will repost a v2 if there are no further comments at the end of the day..


-- 
Regards,
Nishanth Menon
