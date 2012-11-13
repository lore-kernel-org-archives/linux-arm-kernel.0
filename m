From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Nov 2012 15:20:29 +1100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20121113152029.9bcfc18a4bca8dc53a033a86@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in arch/arm/configs/stamp9g20_defconfig between commit 77614e025061 ("arch: Change defconfigs to point to g_mass_storage") from the usb tree and commit 2484575268e2 ("arm: at91: drop machine defconfig") from the arm-soc tree.

The latter deleted the file so I did that and can carry the fix as
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/d65d5179/attachment.sig>
