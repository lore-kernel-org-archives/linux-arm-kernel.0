From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Jan 2018 19:21:19 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Update OPPs to support CA53 dfs
Message-ID: <20180129182121.833-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe frequencies, other than the default for CA53 cores.  This is a
pre-requisite for using providing alternative frequencies for use with
CPUFreq with these cores.

CPUFreq requires Z and Z2 clock support to function.
That this patchset and that dependency can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq-v5

Dien Pham (2):
  arm64: dts: r8a7796: Update OPPs to support CA53 dfs
  arm64: dts: r8a7795: Update OPPs to support CA53 dfs

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.11.0
