From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 16 Feb 2016 16:29:48 +0530
Subject: [PATCH 0/3] net: thunderx: Miscellaneous fixes
Message-ID: <1455620391-31619-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch series fixes couple of issues w.r.t multiqset mode
and receive packet statastics.

Sunil Goutham (3):
  net: thunderx: Fix for multiqset not configured upon interface toggle
  net: thunderx: Fix for HW TSO not enabled for secondary qsets
  net: thunderx: Fix receive packet stats

 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   18 +++++++++---------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    8 ++------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    3 +--
 3 files changed, 12 insertions(+), 17 deletions(-)
