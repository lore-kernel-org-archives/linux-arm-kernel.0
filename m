From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 12:11:01 +0200
Subject: [PATCH 0/3] ASoC: mxs-saif error handling
Message-ID: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series contains error handling patches for mxs-saif. The first patch is
a comment about the possible command sequence of trigger functions.

Regards,

Markus Pargmann


Markus Pargmann (3):
      ASoC: snd_soc_dai_ops trigger function description
      ASoC: mxs-saif: Store saif state
      ASoC: mxs-saif: Handle errors in trigger function

 include/sound/soc-dai.h  |  7 +++++++
 sound/soc/mxs/mxs-saif.c | 30 +++++++++++++++++++++++++-----
 sound/soc/mxs/mxs-saif.h |  5 +++++
 3 files changed, 37 insertions(+), 5 deletions(-)
