From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 19:16:08 +0900
Subject: [PATCH 0/2] Replace /include/ (dtc) with #include
Message-ID: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ (dtc) with #include (C pre-processor) for all ARM64
based SoC dts files.

Pankaj Dubey (2):
  arm64: dts: use #include for all AppliedMicro device tree files
  arm64: dts: use #include for all ARM fast model device tree file

 arch/arm64/boot/dts/apm-mustang.dts    |    2 +-
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.10.4
