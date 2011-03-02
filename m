From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed,  2 Mar 2011 14:13:20 -0800
Subject: [Qualcomm PM8921 MFD 5/6] MAINTAINERS: Add pmic8921,
	pmic8xxx subdevices maintainers
In-Reply-To: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1299104001-5240-6-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Change-Id: I253231c9410930a221351a3d69da95e0014f4786
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 696cb18..97107fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,6 +905,12 @@ F:	drivers/mmc/host/msm_sdcc.h
 F:	drivers/tty/serial/msm_serial.h
 F:	drivers/tty/serial/msm_serial.c
 F:	drivers/platform/msm/
+F:	drivers/mfd/pm8921-core.c
+F:	drivers/mfd/pm8xxx-mpp.c
+F:	include/linux/mfd/pm8921.h
+F:	include/linux/mfd/pm8xxx/
+F:	drivers/gpio/pm8xxx-gpio.c
+F:	drivers/mfd/pm8xxx-irq.c
 T:	git git://codeaurora.org/quic/kernel/davidb/linux-msm.git
 S:	Maintained
 
-- 
1.7.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
