From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 24 Sep 2014 16:51:37 -0700
Subject: [GIT PULL] PM / AVS changes for v3.18
Message-ID: <7hk34sk25y.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

The following changes since commit 0f33be009b89d2268e94194dc4fd01a7851b6d51:

  Linux 3.17-rc6 (2014-09-21 15:43:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git tags/avs-for-3.18

for you to fetch changes up to a99e8f1df57f28d77774d50c94154b4ff1031f27:

  MAINTAINERS: update entry for drivers/power/avs (2014-09-24 16:30:32 -0700)

----------------------------------------------------------------
PM / AVS changes for v3.18

- Add new driver for Rockchip IO voltage domains
- update MAINTAINERS to reflect maintenance of drivers/power/avs/*

----------------------------------------------------------------
Heiko St?bner (1):
      PM / AVS: rockchip-io: add driver handling Rockchip io domains

Kevin Hilman (1):
      MAINTAINERS: update entry for drivers/power/avs

 Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  83 +++++++++++++++++++
 MAINTAINERS                                                    |   4 +-
 drivers/power/avs/Kconfig                                      |   8 ++
 drivers/power/avs/Makefile                                     |   1 +
 drivers/power/avs/rockchip-io-domain.c                         | 351 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 445 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
 create mode 100644 drivers/power/avs/rockchip-io-domain.c
