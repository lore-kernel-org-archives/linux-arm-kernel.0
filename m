From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 11 Sep 2014 17:49:39 -0400
Subject: [GIT PULL] ARM: Keystone fixes for 3.17-rc4
Message-ID: <1410472179-12796-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/fixes-v3.17-rc4

for you to fetch changes up to 99897500e54560397054aa238c771fa8284d0eb2:

  ARM: keystone: dts: fix bindings for pcie and usb clock nodes (2014-09-11 17:41:25 -0400)

----------------------------------------------------------------
Keystone Edision dts fix for -rc cycle. Fix the PCIE and USB nodes.

----------------------------------------------------------------
Murali Karicheri (1):
      ARM: keystone: dts: fix bindings for pcie and usb clock nodes

 arch/arm/boot/dts/k2e-clocks.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
