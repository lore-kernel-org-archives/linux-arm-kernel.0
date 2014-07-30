From: sassmann@kpanic.de (Stefan Assmann)
Date: Wed, 30 Jul 2014 16:36:24 +0200
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53D90159.7040307@suse.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <53D90159.7040307@suse.de>
Message-ID: <53D902E8.1030008@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2014 16:29, Andreas F?rber wrote:
> Hi Stefan,
>
> Glad you got it working. :)
>
> Small nit below:
>
> Am 30.07.2014 16:02, schrieb Stefan Assmann:
>> diff --git a/drivers/clk/ti/clk-6030.c b/drivers/clk/ti/clk-6030.c
>> new file mode 100644
>> index 0000000..baa965b
>> --- /dev/null
>> +++ b/drivers/clk/ti/clk-6030.c
>> @@ -0,0 +1,141 @@
>> +/*
>> + * drivers/clk/ti/clk-6030.c
>> + *
>> + *  Copyright (C) 2014 Stefan Assmann <sassmann@kpanic.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>
> Here you say version 2 ...
>
>> + *
>> + * Clock driver for ti twl6030.
>> + */
> [...]
>> +MODULE_AUTHOR("Stefan Assmann <sassmann@kpanic.de>");
>> +MODULE_DESCRIPTION("clock driver for TI SoC based boards with twl6030");
>> +MODULE_LICENSE("GPL");
>
> ... but down here it's "GPL". Either use "GPL v2" here, or IIUC use the
> "or (at your option) any later version" license above if you can.

Thanks for the hint. I'll fix it in the next version. :)

   Stefan
