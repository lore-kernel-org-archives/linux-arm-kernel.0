From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Sep 2012 16:06:37 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20120920160637.7f9065225982468c25fa1952@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
sound/soc/omap/igep0020.c, sound/soc/omap/omap3beagle.c,
sound/soc/omap/omap3evm.c and sound/soc/omap/overo.c between commit
152c6e56f6a8 ("ASoC: Remove obsolete OMAP3 machine drivers") from the
sound-asoc tree and commit 2203747c9771 ("ARM: omap: move platform_data
definitions") from the arm-soc tree.

The former removed the files, so I did that and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/eb9f54f1/attachment.sig>
