From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 6 Mar 2012 17:24:45 +1100
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20120306172445.81a8461cb8e3b764ce148932@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-mxc/audmux-v1.c between commit 2405fc9728a3 ("ARM: imx:
merge audmux-v1 and audmux-v2") from the sound-asoc tree and commit
48d795616c73 ("ARM: plat-mxc: audmux-v1: Remove unneeded ifdef's") from
the arm-soc tree.

The former removed this file, so I did that.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/c6b4887c/attachment-0001.sig>
