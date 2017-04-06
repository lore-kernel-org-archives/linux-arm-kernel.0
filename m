From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 10:33:11 +0200
Subject: [GIT PULL] Allwinner core changes for 4.12
Message-ID: <20170406083311.be3gu26bk5y2glxd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are some patches for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-core-for-4.12

for you to fetch changes up to 87c586a6a0e166e0403533c2f67a3ae74d26fc14:

  MAINTAINERS: Update the Allwinner sunXi entry (2017-04-04 17:50:59 +0200)

----------------------------------------------------------------
Allwinner core changes for 4.12

A change to our MAINTAINERS entry to reflect the new git tree, and a select
in our KConfig option to enable the device frequency scaling.

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sunxi: Select PM_OPP
      MAINTAINERS: Update the Allwinner sunXi entry

 MAINTAINERS                 | 7 ++++++-
 arch/arm/mach-sunxi/Kconfig | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/7f576eef/attachment.sig>
