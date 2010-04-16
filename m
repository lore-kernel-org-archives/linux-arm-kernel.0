From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Apr 2010 23:54:08 -0400
Subject: [alsa-devel] [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <20100409111609.GA13281@sirena.org.uk>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
	<20100409111609.GA13281@sirena.org.uk>
Message-ID: <m2p771cded01004152054yc1e0d362z16b8f931339e6f36@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 9, 2010 at 7:16 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 31, 2010 at 08:46:42AM -0400, Haojian Zhuang wrote:
>> From b52a0d2687e82f81d38198cb450b6a39a9e53851 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Wed, 31 Mar 2010 15:08:55 -0400
>> Subject: [PATCH] [ARM] pxa: add namespace on ssp
>>
>> In order to prevent code ambiguous, add namespace on functions in ssp driver.
>
> Liam acked these on IRC so I was going to apply them (the interface for
> the sysclk configuration should be fixed, but that can be done as a
> followup patch) but I can't seem to find a branch that these apply to -
> they don't apply cleanly to either Eric's ssp_cleanup branch, the ASoC
> for-2.6.35 branch, nor a merge of the two.
>

Hi Mark,

Excuse me for late response. Now patches are refreshed and they're
still based on Eric's ssp-cleanup branch. Since these patches are
relied on some ssp's fix. Do you want to immigrate these patches into
ASoC's tree? Would you pull eric's ssp-cleanup branch into ASoC tree?

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001--ARM-pxa-add-namespace-on-ssp.patch
Type: text/x-patch
Size: 17845 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100415/01d8b807/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ASoC-split-pxa-ssp-for-reusing-code.patch
Type: text/x-patch
Size: 42408 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100415/01d8b807/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ASoC-support-pxa168-ssp-in-ASoC.patch
Type: text/x-patch
Size: 12530 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100415/01d8b807/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-ASoC-enable-wm8753-in-aspenite.patch
Type: text/x-patch
Size: 7531 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100415/01d8b807/attachment-0007.bin>
