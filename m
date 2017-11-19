From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Nov 2017 13:42:13 +0100
Subject: [PATCH 0/2] ASoC-Rockchip: Fine-tuning for rk_aif1_hw_params()
Message-ID: <255fa488-a5f1-2ea3-dd48-b10ad8b2c18c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 13:34:56 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Delete two unnecessary variable initialisations

 sound/soc/rockchip/rockchip_max98090.c | 13 +++++--------
 sound/soc/rockchip/rockchip_rt5645.c   | 13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

-- 
2.15.0
