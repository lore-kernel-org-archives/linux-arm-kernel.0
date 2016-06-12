From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 12 Jun 2016 13:03:57 +0200
Subject: [GIT PULL] ARM: at91: soc for 4.8 #1
Message-ID: <20160612110357.GA24644@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a rework of the DEBUG_LL stuff for at91 to solve an issue with
multi_v7.

Thanks!

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-soc

for you to fetch changes up to 8b2f2d0356184cc7c409b2f046c550ce00ca8f70:

  ARM: at91: debug: add default DEBUG_LL addresses (2016-06-10 17:09:28 +0200)

----------------------------------------------------------------
SoC changes for 4.8:
 - Solve an issue with DEBUG_LL and multi_v7
 - Also make DEBUG_LL more user friendly

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91: debug: use DEBUG_UART_VIRT
      ARM: at91: debug: add default DEBUG_LL addresses

 arch/arm/Kconfig.debug        | 61 ++++++++++++++++++++++++++++++++-----------
 arch/arm/include/debug/at91.S | 10 +------
 2 files changed, 47 insertions(+), 24 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/066756ed/attachment.sig>
