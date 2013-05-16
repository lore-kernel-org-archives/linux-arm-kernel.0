From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 16 May 2013 13:22:53 +1000
Subject: linux-next: manual merge of the renesas tree with Linus' tree
Message-ID: <20130516132253.8865ca7b6503bd6fe9e6b05a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
arch/arm/mach-shmobile/board-lager.c between commit 65be2de17aae ("ARM:
shmobile: use r8a7790 timer setup code on Lager") from Linus' tree and
commit 993340a1390d ("ARM: shmobile: use r8a7790 timer setup code on
Lager") from the renesas tree.

These are the same patch but different commits :-( and there are further
commits touching this file in the renesas tree.  Please clean up your
tree and remove anything that has already gone upstream as different
patches.  I used the renesas tree version of this file.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130516/881fe7fe/attachment.sig>
