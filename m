From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Nov 2018 14:16:07 +0000
Subject: [PATCH] ARM: smp_twd: Remove legacy TWD registration
In-Reply-To: <20181115100659.18256-1-geert+renesas@glider.be>
References: <20181115100659.18256-1-geert+renesas@glider.be>
Message-ID: <450874f4-59b8-dc70-a19b-550c6c6391a9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2018 10:06, Geert Uytterhoeven wrote:
> As of commit 7484c727b636a838 ("ARM: realview: delete the RealView board
> files"), the ARM Timer and Watchdog Unit is instantiated from DT only.
> Moreover, the driver is selected from ARCH_MULTIPLATFORM platforms only,
> which implies OF, TIMER_OF, and COMMON_CLK.
> 
> Hence remove all unused legacy infrastructure from the driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good cleanup!

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
