From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 16 Oct 2011 16:16:45 +0200
Subject: [PATCH 3/9] ARM: SPMP8000: Add clk support
In-Reply-To: <20111013093836.GK21648@n2100.arm.linux.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-4-git-send-email-zoss@devai.org>
	<20111013093836.GK21648@n2100.arm.linux.org.uk>
Message-ID: <CAGVye5Oy8M3+PBZN2KXMmnstBtxngb0feYELgbnu5ZWxZBHLEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Oct 09, 2011 at 06:36:06PM +0200, Zoltan Devai wrote:
>> --- /dev/null
>> +++ b/arch/arm/mach-spmp8000/clkdev.c
...
>> +#include <mach/scu.h>
>
> I find the use of 'scu' for something which isn't the SMP Coherence Unit
> rather confusing - and I suspect you will too if/when spmp8000 has SMP
> support.
Well, Sunplus decided to name these devices 'SCU', which are a collection
of reset, clock, debug, pinmux and gpio stuff.
The datasheet doesn't even tell what SCU stands for, but I'd prefer to keep
the naming to be in sync with the documentation.

I'll fix the issues pointed out by your other comments in the next version.

Thanks,
Zoltan
