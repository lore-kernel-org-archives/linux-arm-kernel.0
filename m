From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Mar 2018 23:21:51 +0100
Subject: [GIT PULL 2/4] Rockchip soc32 changes for 4.17
In-Reply-To: <12470502.BUvxkRrZk8@phil>
References: <12470502.BUvxkRrZk8@phil>
Message-ID: <138288631.vS67dmqZt1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.17-rockchip-soc32-1

for you to fetch changes up to 03151b8989257bfcee6cfd5f06d9a4a06b781cf3:

  ARM: rockchip: Set name of pmu regmap_config in smp code (2018-03-12 11:09:36 +0100)

----------------------------------------------------------------
Fix for the legacy pmu-regmap in the smp-code to have a real name
and therefore not create a dummy* entry in debugfs.

----------------------------------------------------------------
Jeffy Chen (1):
      ARM: rockchip: Set name of pmu regmap_config in smp code

 arch/arm/mach-rockchip/platsmp.c | 1 +
 1 file changed, 1 insertion(+)
