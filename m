From: eric@anholt.net (Eric Anholt)
Date: Tue, 16 Feb 2016 10:10:59 -0800
Subject: [PATCH v5 01/13] mmc: sdhci-bcm2835: use sdhci_pltfm_init for
 private allocation
In-Reply-To: <1455628111-5583-2-git-send-email-jszhang@marvell.com>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
 <1455628111-5583-2-git-send-email-jszhang@marvell.com>
Message-ID: <87y4ak4jbg.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng Zhang <jszhang@marvell.com> writes:

> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-bcm2835
> to this allocation.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/ecf41af5/attachment.sig>
