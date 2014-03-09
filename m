From: broonie@kernel.org (Mark Brown)
Date: Sun, 9 Mar 2014 11:41:34 +0000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20140309114134.502cdcae7e6a97db684d6b15@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (20140309)
failed for multi_v7_defconfig like this:

ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/socfpga_arria5_socdk.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR (phandle_references): Reference to non-existent node or label "sysmgr"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb] Error 2
make[1]: *** [dtbs] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
Build failed

I have tried using the tree from Friday instead but see following mail.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/96ecf1a1/attachment.sig>
