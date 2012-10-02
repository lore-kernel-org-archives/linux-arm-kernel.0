From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Oct 2012 15:13:27 +1000
Subject: linux-next: manual merge of the arm-soc tree with the spi-mb tree
Message-ID: <20121002151327.bff0573c41ce8d983c392820@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/spi/Kconfig between commit 536a53a300d0 ("spi: remove completely
broken Tegra driver") from the spi-mb tree and commit 5bd276118189 ("spi:
tegra: remove support of legacy DMA driver based access") from the
arm-soc tree.

I fixed it up (by removing the SPI_TEGRA section) and can carry the fix
as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/46803068/attachment-0001.sig>
