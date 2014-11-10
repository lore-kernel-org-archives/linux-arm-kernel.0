From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 10 Nov 2014 12:56:37 +1100
Subject: linux-next: manual merge of the mmc-uh tree with the arm-soc tree
Message-ID: <20141110125637.30fe73b9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Today's linux-next merge of the mmc-uh tree got a conflict in
arch/arm/mach-at91/at91sam9g45_devices.c between commit 4bf7753b8ab7
("ARM: at91: remove at91sam9g45/9m10 legacy board support") from the
arm-soc tree and commit 4049854c41e0 ("ARM: at91: remove
mach/atmel-mci.h") from the mmc-uh tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/b417ef2e/attachment.sig>
