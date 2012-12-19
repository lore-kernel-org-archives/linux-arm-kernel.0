From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Dec 2012 14:56:25 +0100
Subject: [PATCH 0/2] arm: cache-l2x0: aurora: Various bug fixes
Message-ID: <1355925387-9564-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now that we have more devices and more boards supported, bugs shows
up. Here are a couple of fixes that have been tested on Aramda XP
based boards such as DB-78460-BP and DB-MV784MP-GP, and on Armada 370
based boards such as DB-88F6710-BP-DDR3 and Mirabox. They are 3.8
materials.

Thanks,

Gregory CLEMENT (2):
  arm: cache-l2x0: aurora: Invalidate during clean operation with WT
    enable
  arm: cache-l2x0: aurora: Use writel_relaxed instead of writel

 arch/arm/mm/cache-l2x0.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
1.7.9.5
