From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Oct 2017 15:26:22 +0200
Subject: [PATCH v2 0/2] arm64: dts: r8a779[56]: Add OPPs table for cpu devices
Message-ID: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are dependencies for supporting CPUFreq. The remainder of that
work is being posted separately and can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq-v3


A description of steps taken to lightly exercise the same feature for the
r8a7795 the above can be found at the link below. The results are the same
for the r8a7796 with the exception that it has two active CPU cores rather
than four.

http://elinux.org/Tests:R-CAR-GEN3-CPUFreq


Dien Pham (2):
  arm64: dts: r8a7795: Add OPPs table for cpu devices
  arm64: dts: r8a7796: Add OPPs table for cpu devices

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 55 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 58 ++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

-- 
2.1.4
