From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 24 Dec 2012 08:19:08 +0100
Subject: [PATCH v2 0/2] cpts fixes for v3.8-rc2
Message-ID: <cover.1356331925.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changed in v2:
Use clk_prepare_enable instead of clk_prepare + clk_enable.

The new cpts driver has two small issues, but it otherwise seems to be
working in -rc1.

Thanks,
Richard

Richard Cochran (2):
  cpts: fix build error by removing useless code.
  cpts: fix a run time warn_on.

 drivers/net/ethernet/ti/cpts.c |    3 +--
 drivers/net/ethernet/ti/cpts.h |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

-- 
1.7.2.5
