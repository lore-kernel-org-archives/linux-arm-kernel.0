From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 14 May 2010 14:08:56 +0800
Subject: [PATCH 17/20] pxa3xx_nand: add cmdline part parser support
In-Reply-To: <1273804364.9999.881.camel@macbook.infradead.org>
References: <h2l771cded01005060212k39b41e4aqa57cc6e5072bfe3b@mail.gmail.com>
	<1273804364.9999.881.camel@macbook.infradead.org>
Message-ID: <AANLkTikMrVigamYF8VAiEB3_JXGr6LAFliOmw9CJr8mz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 10:32 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2010-05-06 at 05:12 -0400, Haojian Zhuang wrote:
>> From c81c53e24bbbe29ab4bf9767d24de8c45a4470b9 Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Thu, 6 May 2010 10:42:13 +0800
>> Subject: [PATCH] pxa3xx_nand: add cmdline part parser support
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?drivers/mtd/nand/pxa3xx_nand.c | ? 26 ++++++++++++++++++++++++--
>> ?1 files changed, 24 insertions(+), 2 deletions(-)
>
> This conflicts with commit bff3c10d369440bc87ba612b45ba2777d2bf017f.
>
> Some of the other patches in this sequence don't apply cleanly to the
> current mtd-2.6.git tree either; please could you refresh?
>

New patches are rebased for mtd-2.6 master branch. There're contained
in another mail loop.

Thanks
Haojian
