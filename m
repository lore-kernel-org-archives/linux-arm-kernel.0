From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 6 Sep 2013 11:43:24 -0700
Subject: [PATCH v7 1/3] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <20130906171400.GC10973@ohporter.com>
References: <1377882914-30152-1-git-send-email-markus.mayer@linaro.org>
 <1377882914-30152-2-git-send-email-markus.mayer@linaro.org>
 <20130906171400.GC10973@ohporter.com>
Message-ID: <CAPdLdqnAL-0CRFoOJNZ+okVW7FQ5SO7kuPJeqJC=EKD1+kw5zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> --- /dev/null
>> +++ b/drivers/gpio/gpio-bcm-kona.c
>> @@ -0,0 +1,631 @@
>> +/*
>> + * Copyright (C) 2012-2013 Broadcom Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/bitops.h>
>
> Need #include <linux/err.h>

Thanks, Matt. A new version has been posted.

-Markus
