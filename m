From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 13:33:57 -0400
Subject: [GIT PULL] ARM: mvebu: stable fix for v3.10
Message-ID: <20130725173357.GN23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

I'm trying something new.  I've based this branch off of the common
ancestor to the v3.10.x tree (v3.10).  If you could handle it just like
a normal mvebu/fixes branch (ie merge it in for v3.11-rcX), once it hits
mainline, I'll send a PR to the stable folks for the branch.

The advantage of this is that you get the same commit id in both trees
and it's less work for the stable maintainers.

Also, please note the URL change.  I'll post an announcement about that
shortly.

As usual, please tell me if I'm all fouled up. :)

thx,

Jason.


The following changes since commit 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376:

  Linux 3.10 (2013-06-30 15:13:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/stable-3.10

for you to fetch changes up to 449a7d428f46f8bfab68cd15afe7e2eca4c71edb:

  ARM: orion5x: add missing mbus include (2013-07-25 17:01:24 +0000)

----------------------------------------------------------------
mvebu stable changes for v3.10

 - fix build failure for orion5x_defconfig

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: orion5x: add missing mbus include

 arch/arm/mach-orion5x/edmini_v2-setup.c | 1 +
 1 file changed, 1 insertion(+)
