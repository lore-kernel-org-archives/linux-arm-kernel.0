From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 7 Feb 2018 18:35:33 +0100
Subject: [PATCH v1 0/3] STM32 DCMI redundant code & trace cleanup
Message-ID: <1518024936-2455-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove some redundant code and fix/enhance some
error trace points.

Hugues Fruchet (3):
  media: stm32-dcmi: remove redundant capture enable
  media: stm32-dcmi: remove redundant clear of interrupt flags
  media: stm32-dcmi: improve error trace points

 drivers/media/platform/stm32/stm32-dcmi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
1.9.1
