From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:36:44 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mmc tree
Message-ID: <20120924193644.c62d7e91dc2a3f206af9fb65@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mmc/host/omap.c between commit 2976837c6ea8 ("mmc: omap: remove
unused variables and includes") from the mmc tree and commits
cf3a6ec2c0a4 ("ARM: OMAP: remove plat/board.h file") and 70c494c3122f
("ARM: OMAP1: Make plat/mux.h omap1 only") from the arm-soc tree.

The former removed a superset of include files, so I did that and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/b5feffe7/attachment.sig>
