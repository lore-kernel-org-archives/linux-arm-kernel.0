From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 21:10:55 +0100
Subject: [GIT PULL] ARM: at91: defconfig for 4.11
Message-ID: <20170117201055.6jcirstom52lowxa@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A single patch, adding the drivers needed by the newly added Axentia
TSE-850

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-defconfig

for you to fetch changes up to f46b1d47d4a14ddf0f935283c7c0bd0d446c54b0:

  ARM: sama5_defconfig: add support for the Axentia TSE-850 board (2017-01-10 16:13:48 +0100)

----------------------------------------------------------------
defconfig for 4.11:

 - Add driver support for the Axentia TSE-850

----------------------------------------------------------------
Peter Rosin (1):
      ARM: sama5_defconfig: add support for the Axentia TSE-850 board

 arch/arm/configs/sama5_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
