From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 4 Dec 2012 16:51:28 +0100 (CET)
Subject: [PATCH 0/3] mmc: add a card-event host call-back
Message-ID: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a recent thread [1] an extension to the slot-gpio MMC API, adding a 
host call-back for card detection events, has been proposed. This 
extension shall be used by the SDHCI driver to reset the host if the card 
is ejected during a running request. These patches add such a call-back.


Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/17924/focus=17927

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
