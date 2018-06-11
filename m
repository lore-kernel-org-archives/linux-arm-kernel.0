From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 11 Jun 2018 11:50:23 +0200
Subject: [PATCH 0/4] Revisit and fix DCMI buffers handling
Message-ID: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Revisit and fix DCMI buffers handling.

Hugues Fruchet (4):
  media: stm32-dcmi: do not fall into error on buffer starvation
  media: stm32-dcmi: return buffer in error state on dma error
  media: stm32-dcmi: clarify state logic on buffer starvation
  media: stm32-dcmi: revisit buffer list management

 drivers/media/platform/stm32/stm32-dcmi.c | 80 ++++++++++++++++---------------
 1 file changed, 41 insertions(+), 39 deletions(-)

-- 
1.9.1
