From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 12 Aug 2011 18:46:23 +0800
Subject: [PATCH 0/2] Add NAND support for i.MX53EVK board
In-Reply-To: <20110812073034.GC6618@S2100-06.ap.freescale.net>
References: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
	<20110812073034.GC6618@S2100-06.ap.freescale.net>
Message-ID: <CAB4PhKeqa70FxbHzvf2=GJqVfK_PLd=-enYoq9QW0PYxWf7UCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/12 Shawn Guo <shawn.guo@freescale.com>:
> On Fri, Aug 12, 2011 at 03:04:43PM +0800, Jason Liu wrote:
>> This patchset add NAND support for i.MX53EVK board, the patche-set
>> has already been tested on i.MX53EVK board with Samsung K9LAG08U0M
>>
>> Jason Liu (3):
>> ? ARM: i.MX53: Add NAND device support
>> ? ARM: i.MX53EVK: Add NAND support for i.MX53evk board
>>
>> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-mx5/board-mx53_evk.c ? ? ? ? ? ?| ? 47 +++++++++++++++++++++++++
>> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-mx5/devices-imx53.h ? ? ? ? ? ? | ? ?4 ++
>> ?arch/arm/plat-mxc/devices/platform-mxc_nand.c | ? ?5 +++
>> ?6 files changed, 59 insertions(+), 1 deletions(-)
>>
> I would suggest that we stop adding new device into non-dt board
> files. ?Instead, it's more worth to put effort on DT support, as
> the non-dt board files will eventually replaced by DT support.

Anyway, I just put the NAND support patch here for reference in case
others use it.
We eventually need add NAND support for i.MX53 board.

Jason

>
> --
> Regards,
> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
