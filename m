From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 01 Jan 2014 15:40:46 +0100
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <20131231112301.GC16456@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 31 Dec 2013 11:23:02 +0000")
References: <m38uv1uuzr.fsf@t19.piap.pl>
 <20131231112301.GC16456@n2100.arm.linux.org.uk>
Message-ID: <m3bnzvsr2p.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Dec 31, 2013 at 12:20:56PM +0100, Krzysztof Ha?asa wrote:
>> arch/arm/mm/init.c: In function 'setup_dma_zone':
>> arch/arm/mm/init.c:232:19: error: '__pv_phys_offset' undeclared (first use in this function)
>> 
>> Reverting the following commit fixes it:
>
> Already fixed long before Christmas.  Please use recent kernels.

Do you mean something other than Linus's tree? The problem I noted
is present in his tree as of Dec 30 - on both 3.13-rc6 and (then tip)
71ce176ee6ed1735b9a1160a5704a915d13849b1.

Or... do you mean the commit that added this regression?
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
