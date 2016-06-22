From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Wed, 22 Jun 2016 13:31:45 +0100
Subject: [PATCH v2 0/2] can: rcar_canfd: Add Classical CAN & lower state
 transition support
In-Reply-To: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on latest can-next(tag:linux-can-next-for-4.8-20160617).

Changes since v1:
 - property named changed from "can-nofd" to "no-can-fd" (Rob H)
 - added new patch(0002) that support lower state transitions (Wolfgang G)
   (http://marc.info/?l=linux-can&m=146650325116971&w=2)

Ramesh Shanmugasundaram (2):
  can: rcar_canfd: Add Classical CAN only mode support
  can: rcar_canfd: Add back-to-error-active support

 .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-
 drivers/net/can/rcar/rcar_canfd.c                  | 429 ++++++++++++++-------
 2 files changed, 310 insertions(+), 140 deletions(-)

-- 
1.9.1
