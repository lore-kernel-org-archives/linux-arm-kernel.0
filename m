From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Nov 2014 23:51:01 +0100
Subject: [PATCH 1/4] ARM: meson: add basic infrastructure for clocks
In-Reply-To: <20141119224224.25314.58901@quantum>
References: <1416393143-20434-1-git-send-email-carlo@caione.org>
 <1416393143-20434-2-git-send-email-carlo@caione.org>
 <20141119224224.25314.58901@quantum>
Message-ID: <CAOQ7t2ZZ7W2PjkAMhPYhNEmH2+JtUL4td3xV-VbCcL3V-_37Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:42 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Carlo Caione (2014-11-19 02:32:20)
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> new file mode 100644
>> index 0000000..5b6d064
>> --- /dev/null
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -0,0 +1,298 @@
>> +/*
>> + * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>
> All of the headers below are unnecessary. Copy/paste? I didn't bother to
> check the ones above.

No prob. I'll fix them also.

>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>
> Regards,
> Mike

Thanks,

-- 
Carlo Caione
