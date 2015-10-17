From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 17 Oct 2015 17:09:58 +0200
Subject: [GIT PULL] ARM: mvebu: config for v4.4
Message-ID: <87mvvhfs55.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first(and porbaly last) pull request for config for mvebu
for v4.4.

I forgot thie one yesterdau when I sent my second PR series

Gregory

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-config-4.4-1

for you to fetch changes up to ea592ed290c7b4f398227a3025f6e1ff94e767f0:

  ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig (2015-10-12 16:49:13 +0200)

----------------------------------------------------------------
mvebu config for 4.4 (part 1)

Update the v7 defconfig witth usefull config for the Seagate NAS

----------------------------------------------------------------
Simon Guinot (1):
      ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
