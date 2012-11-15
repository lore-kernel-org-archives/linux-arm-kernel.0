From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Nov 2012 16:27:39 +1100
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
Message-ID: <20121115162739.a114b22ad3a1e0b5a04c6aa9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-omap/i2c.c between commit 49839dc93970 ("Revert "ARM: OMAP:
convert I2C driver to PM QoS for MPU latency constraints"") from the
i2c-embedded tree and various commits from the arm-soc tree.

I used the version from the arm-soc tree (not sure if that is the correct
choice) and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/e7df45a7/attachment.sig>
