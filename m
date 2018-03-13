From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 18:16:04 +0100
Subject: [PATCH v1 0/2] Append some fixes and improvements
Message-ID: <1520961366-27473-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix an issue with FIFO Size and burst size.
Fix an incomplete allocator for Hardware descriptors: memory badly
allocated.
---
  Version history:
    v1:
       * Initial
---

Pierre-Yves MORDRET (2):
  dmaengine: stm32-mdma: align TLEN and buffer length on burst
  dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator

 drivers/dma/stm32-mdma.c | 92 ++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

-- 
2.7.4
