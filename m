From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jun 2011 16:17:26 +0100
Subject: [RFC PATCH 10/16] ARM: local timers: add exynos_mct driver to
	driver/clocksource
In-Reply-To: <201106171709.43973.arnd@arndb.de>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<1308251204-16719-11-git-send-email-marc.zyngier@arm.com>
	<201106171709.43973.arnd@arndb.de>
Message-ID: <4DFB7006.9080708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/11 16:09, Arnd Bergmann wrote:
> On Thursday 16 June 2011, Marc Zyngier wrote:
>>
>> Add a "new" driver to driver/clocksource to support the Samsung MCT
>> hardware. This is basically the local timer part of
>> arch/arm/mach-exynos4/mct.c, turned into a platform driver, and
>> with a CPU notifier being used to start/stop timers on secondary
>> cores.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> My feeling is that it would be nicer to do this as an atomic change together
> with the removal of the existing code, rather than two patches.

Happy either way.

	M.
-- 
Jazz is not dead. It just smells funny...
