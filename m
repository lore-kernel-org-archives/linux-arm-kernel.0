From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 10 Mar 2014 07:41:07 +0530
Subject: [PATCH v4 4/5] clk/exynos5260: add macros and documentation for
 exynos5260
In-Reply-To: <531D0229.5070209@gmail.com>
References: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
 <1393931558-23502-5-git-send-email-rahul.sharma@samsung.com>
 <531D0229.5070209@gmail.com>
Message-ID: <CAPdUM4ONxfwDteQqRObg3d9g+bUoge4U06awy6fi7obMPDLjhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2014 05:37, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> Please see some minor comments below.
>
>
> On 04.03.2014 12:12, Rahul Sharma wrote:
>>
>> Add macros which are used as Clock IDs in DT and clock file.
>> It also adds the documentation for the exynos5260 clocks.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>   .../devicetree/bindings/clock/exynos5260-clock.txt |   55 +++++
>>   include/dt-bindings/clk/exynos5260-clk.h           |  233
>> ++++++++++++++++++++
>>   2 files changed, 288 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/clock/exynos5260-clock.txt
>>   create mode 100644 include/dt-bindings/clk/exynos5260-clk.h
>
>
> [snip]
>
>
>> diff --git a/include/dt-bindings/clk/exynos5260-clk.h
>> b/include/dt-bindings/clk/exynos5260-clk.h
>> new file mode 100644
>> index 0000000..4dc20a8
>> --- /dev/null
>> +++ b/include/dt-bindings/clk/exynos5260-clk.h
>
>
> Please use dt-bindings/clock directory.
>
>
>> @@ -0,0 +1,233 @@
>> +/*
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Provides Constants for Exynos5260 clocks.
>> +*/
>
>
> nit: Misaligned star.
>
>
>> +
>> +#ifndef _DT_BINDINGS_CLK_EXYNOS5260_H
>> +#define _DT_BINDINGS_CLK_EXYNOS5260_H
>> +
>> +/*
>> + * Clock names: XXXXXX_YYYYY_ZZZZZ
>> + *                    |------| |----| |----|
>> + *                       cmu       type      IP
>
>
> The alignment looks wrong. Also tabs should be used.
>
>> +*/
>
>
> nit: Misaligned star.
>
>
>> +
>> +/* list of clocks for CMU_TOP */
>
>
> nit: Please properly capitalize comments and end them with a dot, e.g.
>
> /* List of clocks for CMU_TOP. */
>
>> +#define        FIN_PLL                 1
>
>
> nit: No tabs between #define and DEF_NAME, please.
>

I will fix them in v5.

Regards,
Rahul Sharma.

> Best regards,
> Tomasz
