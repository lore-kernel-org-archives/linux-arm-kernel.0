From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 17 Jan 2014 14:23:50 +1100
Subject: linux-next: manual merge of the dt-rh tree with the arm-soc tree
Message-ID: <20140117142350.dc957c59116a9d0885e4724a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the dt-rh tree got a conflict in
Documentation/devicetree/bindings/vendor-prefixes.txt between commits
70e123373c05 ("rtc: Add support for Intersil ISL12057 I2C RTC chip") from
the arm-soc tree and 53d6b36020c7 ("of: Add vendor prefix for LG
Corporation") from Linus' tree and commit 7e73700ce785 ("of: add vendor
prefix for Ka-Ro electronics GmbH") from the dt-rh tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
index d92c88f551f9,d98fa9a6279c..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@@ -42,8 -38,7 +42,9 @@@ ibm	International Business Machines (IB
  idt	Integrated Device Technologies, Inc.
  img	Imagination Technologies Ltd.
  intercontrol	Inter Control Group
 +isl	Intersil
+ karo	Ka-Ro electronics GmbH
 +lg	LG Corporation
  linux	Linux-specific binding
  lsi	LSI Corp. (LSI Logic)
  marvell	Marvell Technology Group Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/e533e2e7/attachment-0001.sig>
