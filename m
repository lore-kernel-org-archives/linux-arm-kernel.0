From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Sep 2012 11:05:00 -0700
Subject: [GIT PULL] ARM: SoC: one more bug fix for 3.6
Message-ID: <CAOesGMhT6xBz-8h76PXuaWNrKa3EK+T2DnX9k8OcFNJONHdvJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 23f3f0613f6172ef1f0cbb0e971adf29f1c1fe5e:

  Merge tag 'imx-fixes' of git://git.pengutronix.de/git/imx/linux-2.6
into fixes (2012-09-18 10:16:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to 84d5dfbf09be6be71d6dda63d99a8303e85663c7:

  ARM: Orion5x: Fix too small coherent pool. (2012-09-26 16:48:47 -0700)

----------------------------------------------------------------
arm-soc: one more bug fix for 3.6

Here's a bugfix for orion5x. Without this, PCI doesn't initialize properly
because of too small coherent pool to cover the allocations needed.

A similar fix has already been done on kirkwood.

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Orion5x: Fix too small coherent pool.

 arch/arm/mach-orion5x/common.c | 7 +++++++
 1 file changed, 7 insertions(+)
