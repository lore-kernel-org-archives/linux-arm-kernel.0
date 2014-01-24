From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jan 2014 23:35:27 +0800
Subject: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC related
 for ARM64
In-Reply-To: <20140123180335.GK27520@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org>
 <20140123180335.GK27520@arm.com>
Message-ID: <52E2883F.1070007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 2014?01?24? 02:03, Catalin Marinas wrote:
> On Fri, Jan 17, 2014 at 12:24:57PM +0000, Hanjun Guo wrote:
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + *  Copyright (C) 2013, Al Stone <al.stone@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + */
>> +
>> +#ifndef _ASM_ARM64_ACPI_H
>> +#define _ASM_ARM64_ACPI_H
> Nitpick: please use __ASM_ACPI_H as a guard for consistency (the same
> for all the other patches introducing new header files).

ok, will update this patch.

Hanjun
>
