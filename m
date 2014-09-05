From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Sep 2014 18:15:49 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.18
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <201409051815.49836.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014, Simon Horman wrote:
> Renesas ARM Based SoC Kconfig Cleanups for v3.18
> 
> * Update name of "R-Car M2-W" SoC (previously there was no "-W")
> * Consolidate Legacy SH_CLK_CPG and CPU_V7 Kconfig
> * Only select PM_RMOBILE for legacy case
> * Cleanup pm-rcar.o and pm-rmobile.o build using Kconfig
> 

Merged into next/cleanup, thanks!

	Arnd
