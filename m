From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2011 17:07:23 +0200
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <201106171707.23989.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011, Marc Zyngier wrote:
> Patches against next-20110615 + my earlier GIC-PPI series. Tested on
> VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.
> 
> Thomas and Arnd cc-ed on the whole series, as this could be
> consolidation material.

Very nice stuff. Should we take this all in one branch in the arm-soc tree,
pending Acks from the subarch maintainers?

We could also push it through the individual subarch branches, but my feeling
is that would be more work.

	Arnd
