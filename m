From: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 04 Oct 2009 16:09:10 +0100
Subject: [RFC PATCH 09/10] PCMCIA: ss: allow PCI IRQs > 255
In-Reply-To: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <7c4c16677fde5e314419bdaa7ef70a8d2e3bdc42.1253722954.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/pcmcia/ss.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 9a3b498..d5a741e 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -172,7 +172,7 @@ struct pcmcia_socket {
 	u_int				irq_mask;
 	u_int				map_size;
 	u_int				io_offset;
-	u_char				pci_irq;
+	u_int				pci_irq;
 	struct pci_dev *		cb_dev;
 
 
-- 
1.6.2.5
