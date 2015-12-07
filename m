From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 17:50:23 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.5 (#1)
Message-ID: <87mvtmcieo.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.5.
(This is part of a first PR series of commit already in linux-next
since a few weeks, if everything goes well, I planned a second PR at
the end of the week)
Gregory

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.5-1

for you to fetch changes up to 4627629bbb675665e902ad76ab96ac1ee5d17fd8:

  ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges (2015-11-30 15:18:31 +0100)

----------------------------------------------------------------
mvebu dt for 4.5 (part 1)

Update partition handling for ix4-300d

----------------------------------------------------------------
Sebastian Hesselbarth (3):
      ARM: dt: mvebu: ix4-300d: remove whole flash partition
      ARM: dt: mvebu: ix4-300d: move partitions to partition sub-node
      ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges

 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 72 ++++++++++++-------------
 1 file changed, 36 insertions(+), 36 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
