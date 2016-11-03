From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  3 Nov 2016 16:07:22 +0100
Subject: [PATCH v8 0/3] ARM, arm64: renesas: Enable UHS-I SDR-104
Message-ID: <1478185645-25556-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series enables SDHI UHS-I SDR-104 on:
* r8a7790/lager
* r8a7791/koelsch
* r8a7794/alt

It is based on renesas-next-20161102-v4.9-rc1.

For functional SDR-104 support the following dependencies are needed:
* [PATCH v8 0/6] UHS-I SDR-104 support for sh_mobile_sdhi

To aid review the following git branches are provided:
* This patchset:
  https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-integration-v8
* This patch-set and above dependency
  https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-v8

Changes since v7:
* Dropped merged matches
* Dropped r8a779[56]/salvator-x patches for now as it seems further work is
  required in order to reliably enable SDR104 on those SoCs.

Simon Horman (3):
  ARM: dts: lager: Enable UHS-I SDR-104
  ARM: dts: koelsch: Enable UHS-I SDR-104
  ARM: dts: alt: Enable UHS-I SDR-104

 arch/arm/boot/dts/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/r8a7794-alt.dts     | 1 +
 3 files changed, 3 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
