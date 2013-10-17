From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 13:08:01 -0600
Subject: [GIT PULL 6/6] MAINTAINERS: Tegra updates, and driver ownership
In-Reply-To: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
References: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1382036881-23339-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Overhaul of MAINTAINERS for Tegra. This adds Thierry as a Tegra core
maintainer, and adds specific entries for most individual Tegra-specific
device drivers, pointing at relevant people. The tegradrm section is
updated to be Supported since Thierry is now employed to work on this.

This branch is based on v3.12-rc1.

----------------------------------------------------------------

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.13-maintainers

for you to fetch changes up to d44c346ee9c9b37ff0ea28e816062cd1439bf05d:

  MAINTAINERS: Tegra updates, and driver ownership

----------------------------------------------------------------

Stephen Warren (1):
      MAINTAINERS: Tegra updates, and driver ownership

 MAINTAINERS | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)
