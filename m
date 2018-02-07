From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Wed, 7 Feb 2018 14:08:53 +0100
Subject: [PATCH 0/2] crypto: stm32/cryp - add AEAD cipher algorithms
Message-ID: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset depends on "crypto: engine - Permit to enqueue all async requests"
proposed by Corentin Labbe [https://lkml.org/lkml/2018/1/26/608].
stm32-cryp uses this updated crpyto engine to handle AEAD cipher algortihms.

Fabien Dessenne (2):
  crypto: stm32/cryp - add aes gcm / ccm support
  crypto: stm32/cryp - add stm32mp1 support

 drivers/crypto/stm32/stm32-cryp.c | 937 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 908 insertions(+), 29 deletions(-)

-- 
2.7.4
