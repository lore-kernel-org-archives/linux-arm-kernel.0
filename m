From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  4 Mar 2016 17:20:11 -0300
Subject: [PATCH 0/2] [media] exynos4-is: Trivial fixes for DT port/endpoint
 parse logic
Message-ID: <1457122813-12791-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series have two trivial fixes for issues that I noticed while
reading as a reference the driver's functions that parse the graph
port and endpoints nodes.

It was only compile tested because I don't have access to a Exynos4
hardware to test the DT parsing, but the patches are very simple.

Best regards,
Javier


Javier Martinez Canillas (2):
  [media] exynos4-is: Put node before s5pcsis_parse_dt() return error
  [media] exynos4-is: FIMC port parse should fail if there's no endpoint

 drivers/media/platform/exynos4-is/media-dev.c | 2 +-
 drivers/media/platform/exynos4-is/mipi-csis.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.5.0
