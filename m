From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jul 2013 17:44:51 +0200
Subject: [PATCH 2/2] ARM: mvebu: add gpio-keys and input event support in
 defconfig
In-Reply-To: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375199091-31215-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Armada 370/XP boards have GPIO buttons, so it makes sense to
enable gpio-keys and the input event interface in mvebu_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 731814e..594d706 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -39,6 +39,8 @@ CONFIG_MVNETA=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MWIFIEX=y
 CONFIG_MWIFIEX_SDIO=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_I2C=y
-- 
1.8.1.2
