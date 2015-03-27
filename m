From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 27 Mar 2015 16:34:08 +0100
Subject: [PATCH 0/4] net/macb: fixes after big driver update
Message-ID: <cover.1427469791.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent modifications to the macb driver lead to issues with the probe
function code flow. Here are some attempt to fix them.
The series is written on top of net-next.

Nicolas Ferre (4):
  net/macb: only probe queues once and use stored values
  net/macb: add comment in macb_probe_queues
  net/macb: fix capabilities configuration
  net/macb: trivial: correct wording of for caps

 drivers/net/ethernet/cadence/macb.c | 55 +++++++++++++++++++------------------
 drivers/net/ethernet/cadence/macb.h |  1 +
 2 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.1.3
