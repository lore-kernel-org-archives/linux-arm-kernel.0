From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 22 Dec 2012 20:41:07 +0100
Subject: [PATCH 0/2] cpts fixes for v3.8-rc2
Message-ID: <cover.1356204860.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new cpts driver has two small issues, but it otherwise seems to be
working in -rc1.

Thanks,
Richard


Richard Cochran (2):
  cpts: fix build error by removing useless code.
  cpts: fix a run time warn_on.

 drivers/net/ethernet/ti/cpts.c |    2 +-
 drivers/net/ethernet/ti/cpts.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

-- 
1.7.2.5
