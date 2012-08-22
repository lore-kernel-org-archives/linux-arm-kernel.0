From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 22 Aug 2012 10:22:54 +0800
Subject: FW: [PATCH V5 0/5] clk: mmp: add clock framework for mmp
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A754366CB@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A754366CB@SC-VEXCH2.marvell.com>
Message-ID: <CADApbehnsRzwu_LrAEMf+L7AvXv+JBtPBOzWHj578Vs6B_LrCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, August 20, 2012 1:39 PM
> To: Chao Xie
> Cc: haojian.zhuang at gmail.com; mturquette at linaro.org; viresh.linux at gmail.com; s.hauer at pengutronix.de; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Chao Xie
> Subject: Re: [PATCH V5 0/5] clk: mmp: add clock framework for mmp
>
> On Monday 20 August 2012, Chao Xie wrote:
>>
>> From: Chao Xie <chao.xie@marvell.com>
>>
>> v1->v2:
>> replace __raw_xxx with xxx_relax
>> use ioremap to remap the registers. Finaly it will use device tree to
>> get the physical address.
>> do not use macro to register clocks, and directly call the functions.
>>
>> v2->v3:
>> pxa910 will have APB extension clock, so some peripharals will have
>> clocks in APB extension base.
>> change pxa168-pwm to be pxa910-pwm for pxa910. It will fit the current
>> pwm driver.
>>
>> v3->v4:
>> remove addtional clock name definition
>> replace left __raw_xxx
>>
>> v4->v5:
>> change the format of the file
>>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
>         Arnd

Who will be responsible for merging these patches?
