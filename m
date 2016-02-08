From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 15:23:21 +0100
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.6 (#1)
Message-ID: <8760xz2sdi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.6.

Gregory

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.6-1

for you to fetch changes up to 727c62d29c3a0b982fb72ef993db95e9d2036e07:

  ARM: mv78xx0: use "depends on" instead of "if" after prompt (2016-01-25 16:43:16 +0100)

----------------------------------------------------------------
mvebu cleanup for 4.6 (part 1)

use "depends on" instead of "if" after prompt for mv78xx0

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: mv78xx0: use "depends on" instead of "if" after prompt

 arch/arm/mach-mv78xx0/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
