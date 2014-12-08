From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 8 Dec 2014 12:06:19 +1100
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
Message-ID: <20141208120619.68287b54@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Today's linux-next merge of the bcm2835 tree got a conflict in
arch/arm/boot/dts/Makefile between commit 302a5ef29d49 ("ARM: BCM5301X:
Add DT for Netgear R6300 V2") from the arm-soc tree and commit
6298ed17a404 ("ARM: bcm2835: Add device tree for Raspberry Pi model
B+") from the bcm2835 tree.

I fixed it up (the bcm2835 tree patch is also in the arm-soc tree as
commit ba2a1d6959ac ("ARM: bcm2835: Add device tree for Raspberry Pi
model B+"), so I just used the arm-soc version) and can carry the fix
as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/3efc234a/attachment.sig>
