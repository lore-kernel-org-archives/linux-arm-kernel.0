From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 19:29:06 +1000
Subject: linux-next: manual merge of the arm-soc tree with the char-misc tree
Message-ID: <20120917192906.48f46e8743de9924f26c782f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/w1/masters/omap_hdq.c between commit 19afea50f12b ("w1: omap-hdq:
convert to devm_* functions") from the char-misc tree and commits
aefaf7be498b ("W1: OMAP HDQ1W: Remove dependencies to mach/hardware.h")
and 73f2989d37a3 ("w1: omap-hdq: drop ARCH dependency") from the arm-soc
tree.

The former patches removed some of the code fixed up by the latter and
the same include line, so I did that and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/72bf4665/attachment-0001.sig>
