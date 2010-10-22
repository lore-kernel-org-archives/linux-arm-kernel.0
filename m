From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 22 Oct 2010 16:44:07 +0800
Subject: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
In-Reply-To: <20101021145249.GA13095@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
	<20101021145249.GA13095@void.printf.net>
Message-ID: <AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 10:52 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Oct 21, 2010 at 03:13:02PM +0100, Chris Ball wrote:
>> On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
>> > Update with comments from Matt and Eric.
>> > Test with sd and emmc.
>> >
>> > >From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:00 2001
>> > From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> > Date: Mon, 20 Sep 2010 10:51:28 -0400
>> > Subject: [PATCH] mmc: add support of sdhci-pxa driver
>> >
>> > ? ? Support Marvell PXA168/PXA910/MMP2 SD Host Controller
>> >
>> > Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> > ---
>> > ?arch/arm/plat-pxa/include/plat/sdhci.h | ? 32 ++++
>> > ?drivers/mmc/host/Kconfig ? ? ? ? ? ? ? | ? 12 ++
>> > ?drivers/mmc/host/Makefile ? ? ? ? ? ? ?| ? ?1 +
>> > ?drivers/mmc/host/sdhci-pxa.c ? ? ? ? ? | ?259 ++++++++++++++++++++++++++++++++
>> > ?4 files changed, 304 insertions(+), 0 deletions(-)
>> > ?create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>> > ?create mode 100644 drivers/mmc/host/sdhci-pxa.c
>>
>> I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
>> patch through the ARM tree.
>
> Oh. ?If we do that then the driver won't compile until everything's
> together, because it #includes <plat/sdhci.h>. ?Haojian/Eric, what do
> you prefer here? ?Should I take the arch/arm/ hunk via the MMC tree?
> (If so, please provide ACKs.)
>

Acked-by: Haojian Zhuang.

I'm fine on this. Please merge it via the MMC tree.


Thanks
Haojian
