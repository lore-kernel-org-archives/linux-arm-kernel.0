From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Jul 2014 23:53:18 +0200
Subject: [PATCH 0/2] spi-orion: one fix and one improvement
Message-ID: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a small patch series agains the spi-orion driver. The first
patch fixes a problem with the handling of the cell-index DT property,
and should be merged for 3.16 as well as backported to -stable.

The second patch adds the support for multiple chip selects, but there
might be some discussion needed on what is the best approach to
describe that in the DT. Suggestions welcome.

Best regards,

Thomas

Thomas Petazzoni (2):
  spi: orion: fix incorrect handling of cell-index DT property
  spi: orion: add support for multiple chip selects

 .../devicetree/bindings/spi/spi-orion.txt          |  3 +++
 drivers/spi/spi-orion.c                            | 26 +++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.0.0
