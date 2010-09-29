From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 29 Sep 2010 13:46:46 -0700
Subject: [PATCH 2/2] msm: defconfig: enable CONFIG_PACKET.
In-Reply-To: <1285793206-5717-1-git-send-email-gbean@codeaurora.org>
References: <1285793206-5717-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1285793206-5717-2-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_PACKET by default so DHCP will work correctly.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/configs/msm_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 2b8f7af..07bfdd9 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -18,6 +18,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=64M console=ttyMSM,115200n8"
 CONFIG_PM=y
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-- 
1.7.0.4

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
