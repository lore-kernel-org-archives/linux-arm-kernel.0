From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 10 Feb 2012 10:50:26 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120210105026.0075dcf9eba39eb98e7b44ef@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-at91/at91cap9.c between commit fa23e771d863 ("Merge branch
'fixes' into for-next") from the arm tree and commit 9918ceafd4a9 ("ARM:
at91: code removal of CAP9 SoC") from the arm-soc tree.

The latter removes the file, so I did that.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120210/3cdd3487/attachment.sig>
