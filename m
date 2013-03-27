From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 28 Mar 2013 09:44:14 +1100
Subject: [GIT PULL] ep93xx-fixes for 3.9-rc5
Message-ID: <5153763E.3010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the follow. It is a regression fix for some ep93xx
boards which are failing to boot on current mainline. The patch has been
tested in next over the last few days.

Thanks,
~Ryan

---

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.9-rc5

for you to fetch changes up to 605c357bb40ce412c086f3a928d07c1d4349b95b:

  ARM: ep93xx: Fix wait for UART FIFO to be empty (2013-03-18 09:40:38 +1100)

----------------------------------------------------------------
H Hartley Sweeten (1):
      ARM: ep93xx: Fix wait for UART FIFO to be empty

 arch/arm/mach-ep93xx/include/mach/uncompress.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
