From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 20 Nov 2009 08:51:31 +0100
Subject: [alsa-devel] i.MX audio support
In-Reply-To: <20091119185426.GA2814@sirena.org.uk>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
	<20091119185426.GA2814@sirena.org.uk>
Message-ID: <eedb5540911192351l5abc7a18s5a218f9b20b58d1b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Theoretically, current merged code only supports i.MX21/27 in the DMA
part. So it would be correct adding a DMA separate driver for i.MX31.

However I disagree with completely new SSI code. It should be possible
to add an arch define to export proper DMA structures whether we are
using i.MX21/27 or i.MX31 in the current SSI driver.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
