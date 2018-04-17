From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Apr 2018 11:09:25 +0100
Subject: [GIT PULL] arm64: dts: juno: fixes for v4.17
Message-ID: <20180417100925.GA16146@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-fixes-4.17

for you to fetch changes up to c326599b29f0dac8d73147309ffd31cce2cfdc05:

  arm64: dts: juno: drop unnecessary address-cells and size-cells properties (2018-04-16 10:15:45 +0100)

----------------------------------------------------------------
ARMv8 Juno DT fix for v4.17

A single patch to fix the new DTC warnings probably enabled during
v4.17 merge window.

----------------------------------------------------------------
Sudeep Holla (1):
      arm64: dts: juno: drop unnecessary address-cells and size-cells properties

 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 2 --
 1 file changed, 2 deletions(-)
