From: rob.clark@linaro.org (Rob Clark)
Date: Thu, 19 Jul 2012 11:23:32 -0500
Subject: [PATCH 0/2] dma-parms and helpers for dma-buf
Message-ID: <1342715014-5316-1-git-send-email-rob.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Clark <rob@ti.com>

Re-sending first patch, with a wider audience.  Apparently I didn't
spam enough inboxes the first time.

And, at Daniel Vetter's suggestion, adding some helper functions in
dma-buf to get the most restrictive parameters of all the attached
devices.

Rob Clark (2):
  device: add dma_params->max_segment_count
  dma-buf: add helpers for attacher dma-parms

 drivers/base/dma-buf.c      |   63 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h      |    1 +
 include/linux/dma-buf.h     |   19 +++++++++++++
 include/linux/dma-mapping.h |   16 +++++++++++
 4 files changed, 99 insertions(+)

-- 
1.7.9.5
