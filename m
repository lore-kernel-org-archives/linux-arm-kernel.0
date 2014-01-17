From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 17 Jan 2014 14:14:20 +1100
Subject: linux-next: manual merge of the devicetree tree with the arm-soc tree
Message-ID: <20140117141420.e70ad2837f74fcff6a7f4a9d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Today's linux-next merge of the devicetree tree got a conflict in
arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts between commit
6b6430e82331 ("ARM: orion5x: Fix typo in device_type property of phy
node") from the arm-soc tree and commit 40aad3c1a9b6 ("dt/bindings:
Remove all references to device_type "ethernet-phy"") from the devicetree
tree.

I fixed it up (removed the line) and can carry the fix as necessary (no
action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/b853f499/attachment.sig>
