From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Jul 2014 11:44:44 +1000
Subject: linux-next: manual merge of the mvebu tree with Linus' tree
Message-ID: <20140717114444.15d99fc2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
drivers/cpuidle/cpuidle-armada-370-xp.c between commit dc559aabe2d4
("cpuidle: mvebu: Fix the name of the states") from Linus' tree and
commit 742450174037 ("cpuidle: mvebu: rename the driver from
armada-370-xp to mvebu-v7") from the mvebu tree.

The former patch appears to have been applied to the
renamed file, so there was nothing to do (except remove the git created
version of the old file).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/cc134c1d/attachment.sig>
