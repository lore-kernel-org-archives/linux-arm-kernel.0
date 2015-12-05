From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Sat,  5 Dec 2015 16:53:02 +0800
Subject: [PATCH 0/2] ARM64: dts: cpufreq: mt8173: Migrate mt8173-cpufreq to
 use OPPv2 bindings
Message-ID: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to migrate mt8173-cpufreq driver to use
operating-points-v2 bindings and add support for mt8173-cpufreq driver

Pi-Cheng Chen (2):
  cpufreq: mt8173: migrate to use operating-points-v2 bindings
  ARM64: dts: mt8173: Add CPU OPP, clock and regulator supply properties

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c            | 20 +++++--
 3 files changed, 122 insertions(+), 6 deletions(-)

-- 
1.9.1
