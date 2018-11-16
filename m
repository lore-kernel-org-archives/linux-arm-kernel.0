From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:48:38 +0100
Subject: [PATCH v1 0/3] Add PM Runtime support
Message-ID: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pm_runtime engine for clock management purpose for both DMA, DMAMUX and
MDMA

---
  Version history:
    v1:
       * Initial
---

Pierre-Yves MORDRET (3):
  dmaengine: stm32-dma: Add PM Runtime support
  dmaengine: stm32-dmamux: Add PM Runtime support
  dmaengine: stm32-mdma: Add PM Runtime support

 drivers/dma/stm32-dma.c    | 58 ++++++++++++++++++++++++++++++++++++++++------
 drivers/dma/stm32-dmamux.c | 58 +++++++++++++++++++++++++++++++++++++---------
 drivers/dma/stm32-mdma.c   | 52 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 144 insertions(+), 24 deletions(-)

-- 
2.7.4
