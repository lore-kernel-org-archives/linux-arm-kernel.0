From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue,  6 Oct 2015 10:19:19 -0700
Subject: [GIT PULL 2/3] Keystone config updates for 4.4
In-Reply-To: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1444151960-4941-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-config

for you to fetch changes up to 1a3284542f2cedc14fa8c4b4de6b9a85eedf4402:

  ARM: configs: keystone: Add basic systemd related options (2015-09-22 08:56:35 -0700)

----------------------------------------------------------------
Couple of ARM Keystone config patches
	- Sync up the config with savedefconfig
	- Add basic systemd options

----------------------------------------------------------------
Nishanth Menon (2):
      ARM: configs: keystone: sync to savedefconfig
      ARM: configs: keystone: Add basic systemd related options

 arch/arm/configs/keystone_defconfig | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)
