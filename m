From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 9 Nov 2017 15:07:56 +0100
Subject: [PATCH 0/2] ASoC: add mclk-fs support to audio graph card
Message-ID: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of these patches is to port mclk-fs property to audio graph card, 
as originally implemented in simple card.

Olivier Moysan (2):
  ASoC: add mclk-fs to audio graph card binding
  ASoC: add mclk-fs support to audio graph card

 .../devicetree/bindings/sound/audio-graph-card.txt |  1 +
 sound/soc/generic/audio-graph-card.c               | 47 ++++++++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

-- 
1.9.1
