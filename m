From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jan 2011 10:11:56 +0200
Subject: [PATCH 7/7] arm: mach-omap1: board-voiceblue: add missing include
In-Reply-To: <1295337165-22934-8-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
	<1295337165-22934-8-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20110118081156.GI2436@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 09:52:45AM +0200, Aaro Koskinen wrote:
> Eliminates the following sparse warnings:
> 
> 	arch/arm/mach-omap1/board-voiceblue.c:253:6: warning: symbol 'voiceblue_wdt_enable' was not declared. Should it be static?
> 	arch/arm/mach-omap1/board-voiceblue.c:261:6: warning: symbol 'voiceblue_wdt_disable' was not declared. Should it be static?
> 	arch/arm/mach-omap1/board-voiceblue.c:269:6: warning: symbol 'voiceblue_wdt_ping' was not declared. Should it be static?
> 	arch/arm/mach-omap1/board-voiceblue.c:278:6: warning: symbol 'voiceblue_reset' was not declared. Should it be static?

wasn't this caused by previous patch ?

-- 
balbi
