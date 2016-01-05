From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jan 2016 12:45:19 +0100
Subject: [PATCH 00/11] mmc: use sdhci_pltfm_init for private allocation
 and clean up
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Message-ID: <8511961.x8LNDTDGG7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 18:51:28 Jisheng Zhang wrote:
> These patches are to complete the TODO in Commit 0e748234293f ("mmc:
> sdhci: Add size for caller in init+register"), I.E:
> 
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
> 

Very nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
