From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 20 Oct 2017 18:22:45 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config update for 4.15
In-Reply-To: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <1508548966-7350-2-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_4.15

for you to fetch changes up to fc88a0631ed0f5b1862d42fb8f2455bf3d18744b:

  ARM: configs: keystone: Enable TIECAP PWM driver (2017-10-09 09:43:32 -0700)

----------------------------------------------------------------
ARM: Enable PWM driver config

----------------------------------------------------------------
Vignesh R (1):
      ARM: configs: keystone: Enable TIECAP PWM driver

 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)
