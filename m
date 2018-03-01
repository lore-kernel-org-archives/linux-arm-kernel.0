From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Mar 2018 16:20:52 +0000
Subject: [GIT PULL] arm64: dts: juno: updates for v4.17
Message-ID: <20180301162052.GA1752@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-4.17

for you to fetch changes up to 3f5098135b2cd23941e5573a3f0abaf75b0e1d0a:

  arm64: dts: juno: fix size of GICv2m MSI frames (2018-02-28 16:58:13 +0000)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.17

1. Extends support for missing 3 GICv2m MSI frames
2. Fixes the incorrect GICv2m frame size(64kB instead of 4kB)

----------------------------------------------------------------
Robin Murphy (1):
      arm64: dts: juno: Describe the full GICv2m region

Sudeep Holla (1):
      arm64: dts: juno: fix size of GICv2m MSI frames

 arch/arm64/boot/dts/arm/juno-base.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)
