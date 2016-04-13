From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 13 Apr 2016 11:22:21 +0200
Subject: [GIT PULL 2/4] Rockchip soc32 updates for v4.7 - part1
In-Reply-To: <2557248.QNyQ7BnmgO@diego>
References: <2557248.QNyQ7BnmgO@diego>
Message-ID: <2240518.rMjkkjGooH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.7-rockchip-soc32-1

for you to fetch changes up to 26d5192953d88d6231d173281848a1c61f9e5d34:

  ARM: rockchip: Fix use of plain integer as NULL pointer (2016-04-12 03:30:30 +0200)

----------------------------------------------------------------
Fix for a sparse build warning in the smp code.

----------------------------------------------------------------
Peter Griffin (1):
      ARM: rockchip: Fix use of plain integer as NULL pointer

 arch/arm/mach-rockchip/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
