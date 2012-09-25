From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:56:03 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20120925165603.7676aa78ed5cfbf8a21fb734@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/mach-vt8500/bv07.c, arch/arm/mach-vt8500/devices-vt8500.c,
arch/arm/mach-vt8500/devices-wm8505.c, arch/arm/mach-vt8500/devices.c,
arch/arm/mach-vt8500/devices.h and arch/arm/mach-vt8500/wm8505_7in.c
between commit 100d45970327 ("ARM: vt8500: Add support for UHCI companion
controller") from the usb tree and commit e9a91de7602a ("arm: vt8500: Update
arch-vt8500 to devicetree support") from the arm-soc tree.

I just removed the files and can carry the fix as necessary (there may be
more work required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/707be684/attachment.sig>
