From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Mar 2015 16:16:26 +1100
Subject: linux-next: manual merge of the kdbus tree with the arm-soc tree
Message-ID: <20150316161626.32e838f5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the kdbus tree got a conflict in
Documentation/Makefile between commit c6535e1e0361 ("Documentation:
Remove ZBOOT MMC/SDHI utility and docs") from the arm-soc tree and
commit 48480f8c402c ("kdbus: add documentation") from the kdbus tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/Makefile
index bc0548201755,5e3fde632d03..000000000000
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@@ -1,4 -1,4 +1,4 @@@
 -subdir-y := accounting arm auxdisplay blackfin connector \
 +subdir-y := accounting auxdisplay blackfin connector \
- 	filesystems filesystems ia64 laptops mic misc-devices \
+ 	filesystems filesystems ia64 kdbus laptops mic misc-devices \
  	networking pcmcia prctl ptp spi timers vDSO video4linux \
  	watchdog
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150316/f0d34e84/attachment.sig>
