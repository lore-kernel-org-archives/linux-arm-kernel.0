From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:53:05 +1000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120924195305.588277e94ce701abc5e5a6c5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/video/omap/lcd_ams_delta.c between commit 9586778de558 ("OMAPFB1:
remove unnecessary includes") from the  tree and commit e27e35ec735f
("ARM: OMAP1: Move board-ams-delta.h from plat to mach") from the arm-soc
tree.

The latter removed a superset of the former (as far as include files is
concerned), so I used that and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/9d60f4eb/attachment.sig>
