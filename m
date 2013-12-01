From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 16:23:50 -0500
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.14
Message-ID: <20131201212350.GY2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This one is a little short.  If you want to hold off pulling until there
are a few more driver commits, that's fine.  However, I don't currently
see anything on the radar, and these are ready.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.14

for you to fetch changes up to 9c8eca3ca43d7337be2485169d4d86a9b6f477d2:

  bus: mvebu-mbus: Remove deprecated comment (2013-11-24 16:39:41 +0000)

----------------------------------------------------------------
mvebu driver changes for v3.14

 - mvebu-mbus:
    - remove potential forever loop
    - remove deprecated comment

----------------------------------------------------------------
Dan Carpenter (1):
      bus: mvebu-mbus: potential forever loop in mvebu_mbus_init()

Ezequiel Garcia (1):
      bus: mvebu-mbus: Remove deprecated comment

 drivers/bus/mvebu-mbus.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)
