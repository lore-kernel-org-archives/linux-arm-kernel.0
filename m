From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 13 Oct 2011 10:18:31 -0700
Subject: [PATCH v2 4/7] clk: Add simple gated clock
In-Reply-To: <20111013144515.GD21648@n2100.arm.linux.org.uk>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-5-git-send-email-mturquette@ti.com>
	<20111013144515.GD21648@n2100.arm.linux.org.uk>
Message-ID: <CAJOA=zMikM=0UT1_qJZ_Tz2dpVLRnqQU2gOCCuhnxqjNPSwWPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 7:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 22, 2011 at 03:26:59PM -0700, Mike Turquette wrote:
>> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
>> new file mode 100644
>> index 0000000..a1d8e79
>> --- /dev/null
>> +++ b/drivers/clk/clk-gate.c
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Simple clk gate implementation
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <asm/io.h>
>
> linux/io.h please.
>

Will roll into v3.

Thanks for reviewing,
Mike
