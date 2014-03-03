From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Mon, 3 Mar 2014 11:28:59 +0000
Subject: [PATCH] MAINTAINERS: Update ARM STi maintainers
Message-ID: <1393846139-18088-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds Maxime and Patrice to ARM/STi maintainers list.
As Stuart Menefy opted to be removed from the list, this patch removes
his email from maintainers. Updated my email with private email address.

This patch also adds few more drivers to the list so that get_maintainer
script can pick the right people to send patch to and avoid email
bounces.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC: Stuart Menefy <stuart.menefy@st.com>
CC: Maxime Coquelin <maxime.coquelin@st.com>
CC: Patrice Chotard <patrice.chotard@st.com>
---
 MAINTAINERS |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85b3dd8..0b74b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1275,13 +1275,21 @@ S:	Maintained
 F:	drivers/clk/socfpga/
 
 ARM/STI ARCHITECTURE
-M:	Srinivas Kandagatla <srinivas.kandagatla@st.com>
-M:	Stuart Menefy <stuart.menefy@st.com>
+M:	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
+M:	Maxime Coquelin <maxime.coquelin@st.com>
+M:	Patrice Chotard <patrice.chotard@st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	kernel at stlinux.com
 W:	http://www.stlinux.com
 S:	Maintained
 F:	arch/arm/mach-sti/
+F:	arch/arm/boot/dts/sti*
+F:	drivers/clocksource/arm_global_timer.c
+F:	drivers/reset/sti/
+F:	drivers/pinctrl/pinctrl-st.c
+F:	drivers/media/rc/st_rc.c
+F:	drivers/i2c/busses/i2c-st.c
+F:	drivers/tty/serial/st-asc.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.7.9.5
