From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Wed, 05 Feb 2014 18:17:46 +0100
Subject: [PATCH v3 0/7] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
In-Reply-To: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
References: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
Message-ID: <2733138.OsaPkZKnhk@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Maxime has pointed out, I've forgotten to add a changelog
in my coverletter.
Here is, what has changed in this revision:

Changes since v1:
-Using mmc_of_parse instead of diy dt parsing
-Adding nodes for all mmc controller to the dtsi files, including sofar unused
  controllers
-Using generic GPIO slot library
-Adding additional MMC device nodes into DTSI files

Changes since v2:
-Add missing Signed-off-by tags
-Stop using __raw_readl / __raw_writel so that barriers are properly used
-Adding missing new lines
-Adding missing patch for automatic reparenting of clocks

cheers
david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/e80036de/attachment.sig>
