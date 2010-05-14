From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 14 May 2010 18:56:44 +0800
Subject: [PATCH 17/20] pxa3xx_nand: add cmdline part parser support
In-Reply-To: <20100514084149.GJ30801@buzzloop.caiaq.de>
References: <h2l771cded01005060212k39b41e4aqa57cc6e5072bfe3b@mail.gmail.com>
	<1273804364.9999.881.camel@macbook.infradead.org>
	<AANLkTikMrVigamYF8VAiEB3_JXGr6LAFliOmw9CJr8mz@mail.gmail.com>
	<1273824971.9999.1582.camel@macbook.infradead.org>
	<20100514084149.GJ30801@buzzloop.caiaq.de>
Message-ID: <AANLkTikzToO-hd0b2o_Ikzess1pwFwO4vdshDTfn7Twc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 4:41 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Fri, May 14, 2010 at 09:16:11AM +0100, David Woodhouse wrote:
>> On Fri, 2010-05-14 at 14:08 +0800, Haojian Zhuang wrote:
>> > New patches are rebased for mtd-2.6 master branch. There're contained
>> > in another mail loop.
>>
>> Hm, please test these by sending to yourself first, saving the patches
>> and checking that they apply.
>>
>> [dwmw2 at macbook mtd-2.6]$ git describe HEAD
>> v2.6.34-rc7-142-gf6b173c
>>
>> [dwmw2 at macbook mtd-2.6]$ for a in `seq -w 1 20` ; do echo Patch $a ; patch -p1 < pxa$a.patch ; done
>> Patch 01
>> patching file arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> patching file drivers/mtd/nand/Kconfig
>> patching file drivers/mtd/nand/pxa3xx_nand.c
>> patch: **** malformed patch at line 203: transfering to/from NAND HW");
>
> Jep, they're line-wrapped, just like the version before.
>
> Haojian, you can avoid this to happen by using 'git send-email'.
>
> Thanks,
> Daniel
>

Now I attach these patches directly. Only 0011 patch is changed to
using dev_dbg for debug print.

Daniel,
Thanks for your advice.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nand_update_mtd2.6.tgz
Type: application/x-gzip
Size: 43854 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100514/b09c789a/attachment-0001.tgz>
