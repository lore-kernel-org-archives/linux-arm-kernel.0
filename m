From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:13:29 -0000
Subject: [RFC PATCH 09/10] PCMCIA: ss: allow PCI IRQs > 255
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <c9f8b2c670bff91e0cca5b1da7ef97bd0c684a49.1256684685.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/pcmcia/ss.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index d696a69..753da9b 100644
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
