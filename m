From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 15:23:49 +0100
Subject: [GIT PULL] ARM: mvebu: drivers for v4.6 (#1)
Message-ID: <874mdj2scq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for drivers for mvebu for v4.6.

Gregory

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.6-1

for you to fetch changes up to 1e78dbe717b1668e1660556930d952447c7c1197:

  ARM: orion: implement ARM delay timer (2016-01-27 10:50:17 +0100)

----------------------------------------------------------------
mvebu driver for 4.6 (part 1)

implement ARM delay timer for orion

----------------------------------------------------------------
Russell King (1):
      ARM: orion: implement ARM delay timer

 arch/arm/plat-orion/time.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
