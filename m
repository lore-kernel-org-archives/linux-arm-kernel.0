From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 16 Aug 2017 17:30:42 -0700
Subject: [GIT PULL 3/3] ARM: SOC: Keystone soc driver update for 4.14
In-Reply-To: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
References: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1502929842-8156-3-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_soc_drivers_4.14

for you to fetch changes up to a1934ff175ff25f57dae8b5107a2351d15729c3a:

  soc: ti: ti_sci_pm_domains: Populate name for genpd (2017-07-28 09:51:34 -0700)

----------------------------------------------------------------
soc: Keystone ti-sci driver genpd fix for 4.14

----------------------------------------------------------------
Dave Gerlach (1):
      soc: ti: ti_sci_pm_domains: Populate name for genpd

 drivers/soc/ti/ti_sci_pm_domains.c | 2 ++
 1 file changed, 2 insertions(+)
