From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Oct 2015 14:32:44 +0100
Subject: [PATCH 0/2] ARM CCN driver fixes
Message-ID: <1444915966-8055-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Here are two tiny CCN driver fixes. The first bug was known for a while
now, but never caused any issue, so the patch wasn't critical.

The second one removes a spurious warning that has been observed last
week, thus is cc-ed to stable.

Both can wait till the next merge window, unless you're willing to
push them out as late fixes in this cycle.

Cheers!

Pawel

Pawel Moll (2):
  bus: arm-ccn: Handle correctly no-more-cpus case
  bus: arm-ccn: Fix irq affinity setting on CPU migration

 drivers/bus/arm-ccn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.1.4
