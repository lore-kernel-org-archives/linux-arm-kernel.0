From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 13 Oct 2016 20:31:19 +0800
Subject: [PATCH v2 0/2] Fix and add more zx dt nodes
Message-ID: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes vs V1:
  - Add more background information for the GIC fix.
  - Fix minor coding style issue.

Jun Nie (2):
  arm64: dts: zx: Fix gic GICR property
  arm64: dts: zx: Add clock controller nodes

 arch/arm64/boot/dts/zte/zx296718.dtsi | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
1.9.1
