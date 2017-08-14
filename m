From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Aug 2017 17:20:24 +0100
Subject: [GIT PULL] arm64: dts: juno: Updates for v4.14
Message-ID: <d33155aa-9925-1a65-ac82-d7cb5e7edd53@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC Team,

Please pull !

Regards,
Sudeep

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-updates-4.14

for you to fetch changes up to 207b6e6b5c9c72ef96ac0da5e9b7c15d1df9f725:

  arm64: dts: juno: replace underscores with hyphen in device node names
(2017-08-02 11:32:14 +0100)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.14

1. Replaces old coresight ATB programmable replicator compatible with
   new and more generic one

2. Replaces incorrect usage of underscores for device node names in the
   device tree with hyphen

----------------------------------------------------------------
Sudeep Holla (1):
      arm64: dts: juno: replace underscores with hyphen in device node names

Suzuki K. Poulose (1):
      arm64: dts: juno: Use the new coresight replicator string

 arch/arm64/boot/dts/arm/foundation-v8.dtsi       |  2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi           | 14 +++++++-------
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)
