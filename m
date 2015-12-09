From: sunil.kovvuri@gmail.com (Sunil Goutham)
Date: Wed,  9 Dec 2015 17:07:59 +0530
Subject: [PATCH 0/2] net: thunderx: Support for pass-2 hw features
In-Reply-To: <y>
References: <y>
Message-ID: <1449661081-15435-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch set adds support for new features added in pass-2 revision
of hardware like TSO and count based interrupt coalescing.

Sunil Goutham (2):
  net: thunderx: HW TSO support for pass-2 hardware
  net: thunderx: Enable CQE count threshold interrupt

 drivers/net/ethernet/cavium/thunder/nic.h          |   14 +++++++--
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   11 ++-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   17 +++++++++--
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   25 ++++++++++++----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    3 +-
 drivers/net/ethernet/cavium/thunder/q_struct.h     |   30 ++++++++++---------
 6 files changed, 65 insertions(+), 35 deletions(-)
