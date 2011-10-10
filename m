From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Oct 2011 19:00:42 +0200
Subject: [PATCH v2 00/14] Sparse fixes for tegra
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <201110101900.42954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 October 2011, Olof Johansson wrote:
> Some trivial fixes removing sparse warnings on tegra code.
> 
> Changes since v1:
> 
> * Implemented Arnd's suggestion to push annotation all the way down to IO_*_VIRT defines
> * Based on above, no longer needed IO_TO_VIRT() -> IO_ADDRESS() changes
> * Added two more fixes for cpu-tegra.
> 
> Stephen; I didn't explicitly apply your Acked-by lines to this batch yet,
> I will do so when I collect final acks before pushing a branch.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
