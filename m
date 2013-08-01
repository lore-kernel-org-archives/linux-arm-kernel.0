From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 10:13:56 -0500
Subject: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
In-Reply-To: <51FA79E0.2070605@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-4-git-send-email-t-kristo@ti.com>
 <51F7E883.7000000@ti.com> <51F8DCF8.2040309@ti.com>
 <51FA69E8.8000000@ti.com> <51FA79E0.2070605@ti.com>
Message-ID: <CAGo_u6oSUMN0LRCg+6MGpWQQKQ7qBPGkgZuffadH5wHmw-H-Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 10:08 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> We should move the functions to this file instead and empty out
>> mach-omap2 gradually, omap_dpll.h should be exported and used by
>> mach-omap2, rather than the other way around.
>
>
> Yeah, the clock stuff should evolve and move here. I just need to start from
> somewhere.

yep, this step is good and as part of this step, moving the used
functions from mach-omap2 to dpll.c is indeed the right step for us to
do proper cleanup.

it is a question of what we bring into drivers/clk and ensuring what
we bring in is clean as well.

Regards,
Nishanth Menon
