From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 16:29:03 +0200
Subject: [PATCH] MAINTAINERS: Update stm32 entry
Message-ID: <1537540143-8177-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Add mailing list for stm32 architecture.
Add "stm" pattern to not miss some drivers/directories when asking for maintainers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Hi Arnd, Olof and Kevin,

Can you please merge this patch for v4.20?

Thanks in advance
Alex

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b..2106e08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2085,10 +2085,12 @@ F:	include/linux/remoteproc/st_slim_rproc.h
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
 M:	Alexandre Torgue <alexandre.torgue@st.com>
+L:	linux-stm32 at st-md-mailman.stormreply.com (moderated for non-subscribers)
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
 N:	stm32
+N:	stm
 F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
-- 
2.7.4
