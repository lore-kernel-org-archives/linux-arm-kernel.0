From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Apr 2017 21:29:27 +0200
Subject: [GIT PULL] Alpine DT for 4.12
Message-ID: <20170414192927.yxgzedeq72bumitk@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following DT changes for the next merge window.

Thanks!
Antoine


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git tags/alpine-dt-for-4.12

for you to fetch changes up to ffdc394e1b4285f8b85663f44f1cbd43003523a7:

  ARM: dts: alpine: add valid clock-frequency values (2017-04-03 09:06:55 +0200)

----------------------------------------------------------------
Alpine DT changes for 4.12

A bunch of clean up for Alpine device trees, nothing fancy.

----------------------------------------------------------------
Antoine Tenart (3):
      ARM: dts: alpine: remove 0x's from the uart1 node unit address
      ARM: dts: alpine: add spaces before the uart node units.
      ARM: dts: alpine: add valid clock-frequency values

Rob Herring (1):
      ARM: dts: alpine: fix PCIe node name

 arch/arm/boot/dts/alpine.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/34134387/attachment.sig>
