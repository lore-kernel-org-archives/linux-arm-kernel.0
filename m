From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 5 Feb 2018 16:48:17 +0300
Subject: [PATCH 05/11] arm64: dts: renesas: initial R8A77980 SoC device
 tree
In-Reply-To: <CAMuHMdWad2OJ33Hu0KbYS3nLWhgmj81_wRbtwApw-N81q3+nsA@mail.gmail.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <32142684-d5cf-035f-8401-86a36dcbafd6@cogentembedded.com>
 <CAMuHMdWad2OJ33Hu0KbYS3nLWhgmj81_wRbtwApw-N81q3+nsA@mail.gmail.com>
Message-ID: <ad83625d-c166-cacb-eae2-a6d64f7d2b26@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2018 4:32 PM, Geert Uytterhoeven wrote:

>> The initial R8A77980 SoC device tree including Cortex-A53 CPU, GIC, timer,
>> CPG, RST, and SYSC.
>>
>> Based on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for the r8a77980 SoC
>> + *
>> + * Copyright (C) 2018 Renesas Electronics Corp.
>> + * Copyright (C) 2018 Cogent Embedded, Inc.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> 
> I think you want to leave out the above #include, as it will go upstream
> through a different path (you're already using hardcoded clock numbers,
> assuming the same).

    I still need CPG_{CORE|MOD}.

> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

    Sorry, I don't see anything worth fixing...

> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
