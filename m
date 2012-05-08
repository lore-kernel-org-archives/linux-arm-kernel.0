From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:43:52 -0600
Subject: [GIT PULL] ARM: tegra defconfig branch
Message-ID: <4FA96968.1040007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is independent from the other pull requests. It mainly enables a
bunch of options for devices on Tegra boards.

P.S. Sorry if this git URL/branch are getting wrapped; they show up
unwrapped in my email client, and it's rewrapping it during the send
operation; I'm not sure how to fix that yet.

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:
  Linus Torvalds (1):
        Linux 3.4-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/defconfig

Stephen Warren (1):
      ARM: tegra: update defconfig

 arch/arm/configs/tegra_defconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)
