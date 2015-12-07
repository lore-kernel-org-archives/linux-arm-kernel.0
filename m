From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 17:51:13 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.5 (#1)
Message-ID: <87io4acida.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.5.
(This is part of a first PR series of commit already in linux-next
since a few weeks, if everything goes well, I planned a second PR at
the end of the week)
Gregory

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.5-1

for you to fetch changes up to a0638365f6850855728a5ef5caf2aeab82a58035:

  ARM: mvebu: add Kirkwood cpuidle to defconfig (2015-11-30 15:26:45 +0100)

----------------------------------------------------------------
mvebu defconfig for 4.5 (part 1)

update of mvebu_v5 defconfig with the addition of cpuidle

----------------------------------------------------------------
Linus Walleij (2):
      ARM: mvebu: update v5 defconfig
      ARM: mvebu: add Kirkwood cpuidle to defconfig

 arch/arm/configs/mvebu_v5_defconfig | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
