From: sunil.kovvuri@gmail.com (Sunil Goutham)
Date: Mon,  7 Dec 2015 10:30:31 +0530
Subject: [PATCH 0/2] net: thunderx: Miscellaneous cleanups 
In-Reply-To: <y>
References: <y>
Message-ID: <1449464433-43343-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch series contains contains couple of cleanup patches.

Sunil Goutham (1):
  net, thunderx: Remove unnecessary rcv buffer start address management

Yury Norov (1):
  net: thunderx: nicvf_queues: nivc_*_intr: remove duplication

 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  189 +++++---------------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |   10 +-
 2 files changed, 51 insertions(+), 148 deletions(-)
