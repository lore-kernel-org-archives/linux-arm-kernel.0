From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Feb 2014 11:48:10 +1100
Subject: linux-next: manual merge of the mvebu tree with Linus' tree
Message-ID: <20140224114810.468d0db355553fc15629592d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
Documentation/devicetree/bindings/vendor-prefixes.txt between commit
d5f93b8ad01e ("of: Update qcom vendor prefix description") from Linus'
tree and commit f7f2ea9f49b0 ("DT: Vendor prefixes: Add ricoh, qnap, sii
and synology") from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>

diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
index e9d19e2b359b,c73b435f58f5..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@@ -69,7 -64,8 +69,8 @@@ phytec	PHYTEC Messtechnik Gmb
  picochip	Picochip Ltd
  powervr	PowerVR (deprecated, use img)
  qca	Qualcomm Atheros, Inc.
 -qcom	Qualcomm, Inc.
 +qcom	Qualcomm Technologies, Inc
+ qnap	QNAP Systems, Inc.
  ralink	Mediatek/Ralink Technology Corp.
  ramtron	Ramtron International
  realtek Realtek Semiconductor Corp.
@@@ -81,9 -78,9 +83,10 @@@ schindler	Schindle
  sil	Silicon Image
  silabs	Silicon Laboratories
  simtek
+ sii	Seiko Instruments, Inc.
  sirf	SiRF Technology, Inc.
  snps 	Synopsys, Inc.
 +spansion	Spansion Inc.
  st	STMicroelectronics
  ste	ST-Ericsson
  stericsson	ST-Ericsson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/3de9b684/attachment.sig>
