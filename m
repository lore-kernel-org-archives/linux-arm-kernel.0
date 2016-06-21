From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Jun 2016 19:04:54 +0200
Subject: [GIT PULL] ARM: at91: soc for 4.8 #2
Message-ID: <20160621170454.GA15832@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here are more compilation warning fixes and the final documentation for the
sama5d2 that we forgot about.

The following changes since commit 8b2f2d0356184cc7c409b2f046c550ce00ca8f70:

  ARM: at91: debug: add default DEBUG_LL addresses (2016-06-10 17:09:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-soc2

for you to fetch changes up to ab6778eee51b72f2dae79763bf918e3d43331c12:

  ARM: at91: fix warnings in pm.c (2016-06-21 17:32:31 +0200)

----------------------------------------------------------------
SoC changes for 4.8 #2:
 - Add final documentation for sama5d2
 - Fix some compilation warnings

----------------------------------------------------------------
Ben Dooks (1):
      ARM: at91: fix warnings in pm.c

Nicolas Ferre (1):
      ARM: at91: Documentation: update the sama5d2 entry

 Documentation/arm/Atmel/README | 10 ++++++++--
 arch/arm/mach-at91/pm.c        |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/ca13e1ec/attachment.sig>
