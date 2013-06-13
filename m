From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Jun 2013 17:21:37 -0400
Subject: [GIT PULL 1/3] ARM: mvebu: cleanup for v3.11 #4
Message-ID: <20130613212137.GE31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c589f9b4b51317cfc530812fe90a9895bd51430e:

  arm: mvebu: mark functions of armada-370-xp.c as static (2013-05-21 13:44:32 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-4

for you to fetch changes up to b15d0b5256056a67c5cb14c2d4d46dd12c8bfb99:

  bus: mvebu-mbus: Use pr_fmt (2013-06-08 14:10:19 +0000)

----------------------------------------------------------------
mvebu cleanup for v3.11 (round 4)

 - mvebu
    - use pr_fmt in mvebu-mbus driver

----------------------------------------------------------------
Ezequiel Garcia (1):
      bus: mvebu-mbus: Use pr_fmt

 drivers/bus/mvebu-mbus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
