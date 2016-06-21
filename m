From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 21 Jun 2016 11:35:43 +0200
Subject: [PATCH] MAINTAINERS: update STi maintainer list
Message-ID: <1466501743-21597-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove myself as STi maintainer as I will no longer have access to
STi platforms, and remove Srini too, who now works on other
platforms.

Patrice will manage the pull requests.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..1ea14565d9d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1689,8 +1689,6 @@ S:	Maintained
 F:	drivers/edac/altera_edac.
 
 ARM/STI ARCHITECTURE
-M:	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
-M:	Maxime Coquelin <maxime.coquelin@st.com>
 M:	Patrice Chotard <patrice.chotard@st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	kernel at stlinux.com
-- 
1.9.1
