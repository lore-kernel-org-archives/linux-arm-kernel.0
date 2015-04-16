From: joe@perches.com (Joe Perches)
Date: Thu, 16 Apr 2015 15:49:25 -0700
Subject: [trivial PATCH] arm: dts: socfpga: Remove executable permission bits
Message-ID: <1429224565.2850.62.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the .dts file permissions from 755 to 644.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dts | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
old mode 100755
new mode 100644
