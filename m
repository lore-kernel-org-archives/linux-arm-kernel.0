From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 22 Oct 2018 17:10:44 +0200
Subject: [PATCH 0/2] ASoC: stm32: sai: fix kbuild errors
Message-ID: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix following compilation errors:
- >> sound/soc/stm/stm32_sai_sub.c:260:16: error: field 'hw' has incomplete type
- >> sound/soc/stm/stm32_sai_sub.c:412:3: 
     warning: 'strncat' specified bound 6 equals source length [-Wstringop-overflow=]

Olivier Moysan (2):
  ASoC: stm32: add clock dependency for sai
  ASoC: stm32: sai: fix master clock naming

 sound/soc/stm/Kconfig         | 1 +
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
