From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:23 +0200
Subject: [PATCH 5/5] ARM: configs: Add new config fragment to change RAM size
In-Reply-To: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
References: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1477494683-29890-6-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/dram_size_0x2000000.config b/arch/arm/configs/dram_size_0x2000000.config
new file mode 100644
index 0000000..e66430d
--- /dev/null
+++ b/arch/arm/configs/dram_size_0x2000000.config
@@ -0,0 +1 @@
+CONFIG_DRAM_SIZE=0x002000000
-- 
1.9.1
