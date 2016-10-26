From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:22 +0200
Subject: [PATCH 4/5] ARM: configs: Add new config fragment to change RAM start
 point
In-Reply-To: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
References: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1477494683-29890-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/dram_0xc0000000.config b/arch/arm/configs/dram_0xc0000000.config
new file mode 100644
index 0000000..343d533
--- /dev/null
+++ b/arch/arm/configs/dram_0xc0000000.config
@@ -0,0 +1 @@
+CONFIG_DRAM_BASE=0xc0000000
-- 
1.9.1
