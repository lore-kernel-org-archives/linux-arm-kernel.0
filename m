From: shaun.ren@linux.com (Shaun Ren)
Date: Thu, 11 Feb 2016 20:07:52 -0800
Subject: [PATCH v4 0/8] Staging: rts5208: Fix coding style
In-Reply-To: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
References: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes the coding style issues in rtsx_transport.c.

Changes since v3
 * Removed the extraneous SCSI comment in the first patch
 * Removed the last patch (Staging: rts5208: Add missing dma_mapping_error)
   as it is already done in change 9a66d05d82db
   (Staging: rts5208: fix check for dma mapping error)

Changes since v2
 * Incorporated Joshua Clayton's suggestions regarding the block comments



Shaun Ren (8):
  Staging: rts5208: rtsx_transport.c: Cleanup comments
  Staging: rts5208: rtsx_transport.c: Align to open parenthesis
  Staging: rts5208: rtsx_transport.c: Remove spaces after casts
  Staging: rts5208: rtsx_transport.c: Add spaces around -
  Staging: rts5208: rtsx_transport.c: Remove extra newlines
  Staging: rts5208: rtsx_transport.c: Fix label naming convention
  Staging: rts5208: rtsx_transport.c: Remove unnecessary parentheses
  Staging: rts5208: rtsx_transport.c: Fix comparisons to NULL

 drivers/staging/rts5208/rtsx_transport.c | 152 ++++++++++++++++---------------
 1 file changed, 81 insertions(+), 71 deletions(-)

-- 
2.7.0
