From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:46 -0600
Subject: [GIT PULL 8/8] ARM: tegra: defconfig changes
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various new features are enabled:

* Tegra114 support.
* Various PMICs and related options for Tegra114 platforms.
* KEYBOARD_GPIO, mainly as a suspend wakeup source.
* tegra_defconfig is rebuilt based on v3.9-rc1, which causes various
  layout changes.

This branch is based on v3.9-rc1.

----------------------------------------------------------------

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-defconfig

for you to fetch changes up to e1eee65f1a0cce8e49624104b3497ba3f8d35199:

  ARM: tegra: defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
