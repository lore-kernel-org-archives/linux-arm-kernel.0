From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 11:07:24 -0700
Subject: [GIT PULL 2/2] ARM: tegra: second set of defconfig changes
In-Reply-To: <1387562844-32497-1-git-send-email-swarren@wwwdotorg.org>
References: <1387562844-32497-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387562844-32497-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains changes to tegra_defconfig that came in after
I sent the previous pull-request/tag tegra-for-3.14-defconfig. We enable:

* DRM_PANEL/DRM_PANEL_SIMPLE, which implements the built-in LCD panel
  support for Harmony, Cardhu, and Dalmore.

This branch is based on tag tegra-for-3.14-defconfig, for which I sent a
previous pull request.

----------------------------------------------------------------

The following changes since commit 0d8c67218cef8af259e4d12221434a1d7b0f3bbc:

  ARM: tegra: tegra_defconfig updates

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-defconfig-2

for you to fetch changes up to cb99fd620045c0a85593d52b7b1084fa69248b5e:

  ARM: tegra: Enable DRM panel support

----------------------------------------------------------------

Thierry Reding (1):
      ARM: tegra: Enable DRM panel support

 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)
