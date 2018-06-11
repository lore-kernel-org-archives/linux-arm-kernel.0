From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 11 Jun 2018 17:13:58 +0200
Subject: [PATCH v2 0/1] ASoC: stm32: sai: add iec958 controls support
Message-ID: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes v2:
- Remove iec958 helpers and implement iec958 controls in sai driver 

Olivier Moysan (1):
  ASoC: stm32: sai: add iec958 controls support

 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 139 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 12 deletions(-)

-- 
1.9.1
