From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 May 2017 11:16:18 -0700
Subject: [PATCHv3b 0/5] ARM: OMAP2+: preparation for clk/clkctrl support
In-Reply-To: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
Message-ID: <20170530181618.GC3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170530 07:51]:
> Hi,
> 
> This is an alternative solution against v3 [1] of this series.
> 
> [1]?https://www.spinics.net/lists/arm-kernel/msg581965.html
> 
> This series is different in that it parses the hwmod data in the fly
> and swaps the main_clk info with clkctrl implementations if those
> are present. Patch #1 / #2 are old from v3 of the series, rest are
> new. Patches #3 / #4 add some infrastructure support for parsing
> the clock data, and patch #5 does the clock swapping.
> 
> With this series, it is not necessary to populate clkctrl clock
> entries to DT at all, thus the transition should be smoother.

Yeah OK I think this is the way to go to avoid changing
device tree multiple times. The only issues I have are
for patches 4 and 5 that I already commented on there.

Regards,

Tony
