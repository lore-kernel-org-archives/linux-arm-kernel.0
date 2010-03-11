From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 11 Mar 2010 16:20:35 +0800
Subject: [PATCH 2/4] mmp: support ssp in pxa168
In-Reply-To: <20100310142832.GB24422@rakim.wolfsonmicro.main>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
	<20100310142832.GB24422@rakim.wolfsonmicro.main>
Message-ID: <f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 10:28 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 10, 2010 at 08:14:42AM -0500, Haojian Zhuang wrote:
>> From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Wed, 10 Mar 2010 06:32:43 -0500
>> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
>>
>> Support ssp in pxa168. The basic function of SSP is same as pxa, but clock
>> source and IRQ is changed.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> That said might it make sense to merge this and the previous patch via
> ASoC since there's new drivers using this following on and Liam's
> multi-codec work is likely to be creating merge issues this development
> cycle? ?I can apply the patches on a branch by themselves which can also
> be pulled into the PXA tree if needed.
>

I'd expect there to be some merge conflicts I need to solve along with
my cleaning up of the SSP code. That said, it's better to go via -pxa
tree and get the multi-codec work solved in linux-next?

Mark, could you please point me the reference to the multi-codec work
so I can have a rough feeling of the possible merge issues?

- eric
