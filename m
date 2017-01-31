From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 31 Jan 2017 14:14:25 +0100
Subject: [PATCH 8/8] ARM: configs: Add new config fragment to change RAM start
 point
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485868465-30446-9-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new fragment to over-ride the RAM start point to 0xd0000000.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/dram_0xd0000000.config b/arch/arm/configs/dram_0xd0000000.config
new file mode 100644
index 0000000..61ba704
--- /dev/null
+++ b/arch/arm/configs/dram_0xd0000000.config
@@ -0,0 +1 @@
+CONFIG_DRAM_BASE=0xd0000000
-- 
1.9.1
