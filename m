From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 18:01:57 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mmc tree
Message-ID: <20120917180157.dada1de4e34b3dcf59971ccd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mmc/host/omap.c between commit 2976837c6ea8 ("mmc: omap: remove
unused variables and includes") from the mmc tree and commit cf3a6ec2c0a4
("ARM: OMAP: remove plat/board.h file") from the arm-soc tree.

The latter is a subset of the former.

I fixed it up and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/04e54048/attachment-0001.sig>
