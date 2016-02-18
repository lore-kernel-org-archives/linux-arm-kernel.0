From: rrichter@caviumnetworks.com (Robert Richter)
Date: Thu, 18 Feb 2016 13:39:07 +0100
Subject: [PATCH 0/2] net: thunderx: Small cleanups
Message-ID: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Sending two small cleanups of the driver fixing issues found during
code review.

Robert Richter (2):
  net: thunderx: Fix const type in nicvf_set_rxfh()
  net, thunderx: Use bool in structs where possible

 drivers/net/ethernet/cavium/thunder/nic.h           | 12 ++++++------
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.0.rc3
