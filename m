From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed, 16 Mar 2011 19:24:00 -0700
Subject: [PM8921 MFD V3 5/6] MAINTAINERS: Add patterns for pmic 8921 files to
	MSM subsystem
In-Reply-To: <1300328641-3855-1-git-send-email-adharmap@codeaurora.org>
References: <1300328641-3855-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1300328641-3855-6-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 696cb18..71566a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,6 +905,8 @@ F:	drivers/mmc/host/msm_sdcc.h
 F:	drivers/tty/serial/msm_serial.h
 F:	drivers/tty/serial/msm_serial.c
 F:	drivers/platform/msm/
+F:	drivers/*/pm8???-*
+F:	include/linux/mfd/pm8xxx/
 T:	git git://codeaurora.org/quic/kernel/davidb/linux-msm.git
 S:	Maintained
 
-- 
1.7.1
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
