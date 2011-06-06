From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon,  6 Jun 2011 15:24:14 +0100
Subject: [PATCH 2/3] pxa2xx trizeps4: pcmcia remove unnecessary ifdefs
In-Reply-To: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
References: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <1307370255-15963-3-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/pcmcia/pxa2xx_trizeps4.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index b829e65..57ddb96 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -55,10 +55,6 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		}
 		skt->socket.pci_irq = IRQ_GPIO(GPIO_PRDY);
 		break;
-
-#ifndef CONFIG_MACH_TRIZEPS_CONXS
-	case 1:
-#endif
 	default:
 		break;
 	}
-- 
1.7.3.4
