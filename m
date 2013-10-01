From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue,  1 Oct 2013 14:36:09 +0200
Subject: [PATCH 0/2] ASoC: fix sound on mx31moboard
Message-ID: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Theses two patches are necessary to get back the sound working on 
mx31moboards. 
The first one fix imx-ssi to work even if only the dma is available.
The second one fix the audmux settings on mx31moboard boards.

Thanks,

Philippe

Philippe R?tornaz (2):
  ASoC: fsl: imx-ssi: fix probe on imx31
  ASoC: fsl: Fix sound on mx31moboard

 sound/soc/fsl/imx-mc13783.c |    2 +-
 sound/soc/fsl/imx-ssi.c     |   23 ++++++++++++-----------
 sound/soc/fsl/imx-ssi.h     |    2 ++
 3 files changed, 15 insertions(+), 12 deletions(-)

-- 
1.7.9.5
