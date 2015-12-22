From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 22 Dec 2015 17:01:59 +0100
Subject: [GIT PULL v2] at91: DT for 4.5 #2
Message-ID: <20151222160159.GA9225@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here are more DT materials for 4.5, please pull.

The following changes since commit 0a804b5729bb0021e63662b772db0f52de653056:

  ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time (2015-12-15 12:23:32 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-4.5-dt2

for you to fetch changes up to ca6349a8c51f2e3d6f2acdb36431e7d7328261f7:

  ARM: at91/dt: sama5d2 Xplained: add pdmic node (2015-12-22 10:37:53 +0100)

----------------------------------------------------------------
Second batch of DT changes for 4.5:
- addition of sound nodes for sama5d2 and its xplained board
- addition of a new platform, Landis + Gyr VInCo

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: at91/dt: Add Support for the L+G VInCo platform

Songjun Wu (2):
      ARM: at91/dt: sama5d2: add pdmic node
      ARM: at91/dt: sama5d2 Xplained: add pdmic node

 arch/arm/boot/dts/Makefile                  |   3 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  16 ++
 arch/arm/boot/dts/at91-vinco.dts            | 256 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              |  24 +++
 4 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-vinco.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/e680c26e/attachment.sig>
