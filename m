From: eltshanli@gmail.com (Li Jie)
Date: Mon, 21 Dec 2009 14:19:31 +0800
Subject: [PATCH] ARM: NUC900: Add cpufreq driver for nuc900 CPUs
In-Reply-To: <20091219130729.GA1699@n2100.arm.linux.org.uk>
References: <8fb2581d0912132329k1b1a52c8sdabfc4af3266c1e5@mail.gmail.com>
	<20091219130729.GA1699@n2100.arm.linux.org.uk>
Message-ID: <8fb2581d0912202219m10af202asdcee8658be63fc4c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2009 at 9:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 14, 2009 at 03:29:42PM +0800, Li Jie wrote:
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/init.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +
>> +#include <asm/io.h>
>
> I'm still on my crusade against this. ?linux/io.h please.
>

OK, thank you for the comment.

-- 
Regards
Li Jie
