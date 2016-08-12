From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 12 Aug 2016 17:25:51 +0100
Subject: [PATCH 0/5] CCN fixes for 4.8
Message-ID: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings, Arnd, Olof, Kevin,

This is a small set of various CCN driver fixes I accumulated over the
last few weeks.

I'll send a pull request later, probably next week, that will also
include Mark's patches he sent out yesterday.

Pawel Moll (5):
  bus: arm-ccn: Fix PMU handling of MN
  bus: arm-ccn: Do not attempt to configure XPs for cycle counter
  bus: arm-ccn: Fix XP watchpoint settings bitmask
  bus: arm-ccn: Correct required arguments for XP PMU events
  bus: arm-ccn: Add missing event attribute exclusions for host/guest

 drivers/bus/arm-ccn.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.7.4
