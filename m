From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:50 -0700
Subject: [PATCH v2 00/14] Sparse fixes for tegra
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some trivial fixes removing sparse warnings on tegra code.

Changes since v1:

* Implemented Arnd's suggestion to push annotation all the way down to IO_*_VIRT defines
* Based on above, no longer needed IO_TO_VIRT() -> IO_ADDRESS() changes
* Added two more fixes for cpu-tegra.

Stephen; I didn't explicitly apply your Acked-by lines to this batch yet,
I will do so when I collect final acks before pushing a branch.


-Olof
