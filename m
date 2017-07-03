From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 3 Jul 2017 17:21:06 +0100
Subject: [PATCH] ARM64: dts: marvell: armada37xx: Fix timer interrupt
 specifiers
In-Reply-To: <877ezpve2e.fsf@free-electrons.com>
References: <20170621214508.7810-1-marc.zyngier@arm.com>
 <871sqazxc3.fsf@free-electrons.com> <877ezpve2e.fsf@free-electrons.com>
Message-ID: <ba089e0e-e184-7005-2354-21a72c441f1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 03/07/17 14:35, Gregory CLEMENT wrote:
> Hi,
>  
>  On ven., juin 23 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
>> Hi Marc,
>>  
>>  On mer., juin 21 2017, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>>> Contrary to popular belief, PPIs connected to a GICv3 to not have
>>> an affinity field similar to that of GICv2. That is consistent
>>> with the fact that GICv3 is designed to accomodate thousands of
>>> CPUs, and fitting them as a bitmap in a byte is... difficult.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Applied on mvebu/fixes
> 
> As I missed the end of the merge window for 4.12, I've just moved this
> patch on mvebu/dt64 wit the hope that it can be applied on a late dt
> branch on arm-soc for 4.13.
> 
> I also added the "Fixes" and "CC: stable" tags in order to propagate the
> fix on older kernel.

While you're at it, you could also add the couple of GIC-related fixes
I've posted on Saturday (which are equally important).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
