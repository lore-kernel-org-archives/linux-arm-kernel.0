From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Feb 2011 14:35:52 +0000
Subject: [patch 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110228132643.964403175@rtp-net.org>
References: <20110228132132.654689676@rtp-net.org>
	<20110228132643.964403175@rtp-net.org>
Message-ID: <20110228143552.GC13869@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 02:21:33PM +0100, Arnaud Patard wrote:
> By default, on wdi (watchdog input) event the mc13892 is powering off.
> This patch is changing this to reboot on wdi event.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

This strikes me as something that should be configurable by platforms.
