From: fthain@telegraphics.com.au (Finn Thain)
Date: Mon, 5 May 2014 15:35:30 +1000 (EST)
Subject: [PATCH] MAINTAINERS: add an entry for all the NCR5380 drivers
Message-ID: <alpine.LNX.2.00.1405051458460.16664@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>

---

As requested:
http://marc.info/?l=linux-arm-kernel&m=139853302724112&w=2

diff --git a/MAINTAINERS b/MAINTAINERS
index e67ea24..60ea600 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5996,6 +5996,28 @@ M:	Petr Vandrovec <petr@vandrovec.name>
 S:	Odd Fixes
 F:	fs/ncpfs/
 
+NCR 5380 SCSI DRIVERS
+M:	Finn Thain <fthain@telegraphics.com.au>
+M:	Michael Schmitz <schmitzmic@gmail.com>
+L:	linux-scsi at vger.kernel.org
+S:	Maintained
+F:	Documentation/scsi/g_NCR5380.txt
+F:	drivers/scsi/NCR5380.*
+F:	drivers/scsi/arm/cumana_1.c
+F:	drivers/scsi/arm/oak.c
+F:	drivers/scsi/atari_NCR5380.c
+F:	drivers/scsi/atari_scsi.*
+F:	drivers/scsi/dmx3191d.c
+F:	drivers/scsi/dtc.*
+F:	drivers/scsi/g_NCR5380.*
+F:	drivers/scsi/g_NCR5380_mmio.c
+F:	drivers/scsi/mac_scsi.*
+F:	drivers/scsi/pas16.*
+F:	drivers/scsi/sun3_NCR5380.c
+F:	drivers/scsi/sun3_scsi.*
+F:	drivers/scsi/sun3_scsi_vme.c
+F:	drivers/scsi/t128.*
+
 NCR DUAL 700 SCSI DRIVER (MICROCHANNEL)
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 L:	linux-scsi at vger.kernel.org
