From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 1 Jul 2016 13:50:36 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: support the pmu node for rk3399
In-Reply-To: <20160701102612.GB22953@leverpostej>
References: <1467358570-24417-1-git-send-email-wxt@rock-chips.com>
 <1467358570-24417-3-git-send-email-wxt@rock-chips.com>
 <20160701102612.GB22953@leverpostej>
Message-ID: <5776671C.7000808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/16 11:26, Mark Rutland wrote:
> On Fri, Jul 01, 2016 at 03:36:10PM +0800, Caesar Wang wrote:
>> As the Marc posted the patches [0] to support Partitioning per-cpu
>> interrupts. Let's add this patch to match it on rk3399 SoCs.
>>
>> [0]:
>> https://lkml.org/lkml/2016/4/11/182
> 
> The core IRQ support is merged, but it's worth noting that the perf code
> doesn't use it yet. So we still need a patch adding support to the perf
> code before we can change the dts.
> 
> I think Marc had a prototype of that somewhere.
> 
> Marc?

I posted something in the original discussion, but need to respin it.
Stay tuned.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
