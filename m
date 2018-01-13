From: daniel@makrotopia.org (Daniel Golle)
Date: Sat, 13 Jan 2018 18:32:59 +0100
Subject: [PATCH] ARM: dts: rename oxnas dts files
Message-ID: <20180113173253.GA30674@makrotopia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other platforms' device-tree files start with a platform prefix, such as
sun7i-a20-*.dts or at91-*.dts.
This naming scheme turns out to be handy when using multi-platform build
systems such as OpenWrt.
Prepend oxnas files with their platform prefix to comply with the naming
scheme already used for most other platforms.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm/boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts}                    | 0
 ...nes-pogoplug-series-3.dts => ox820-cloudengines-pogoplug-series-3.dts} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts} (100%)
 rename arch/arm/boot/dts/{cloudengines-pogoplug-series-3.dts => ox820-cloudengines-pogoplug-series-3.dts} (100%)

diff --git a/arch/arm/boot/dts/wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
similarity index 100%
rename from arch/arm/boot/dts/wd-mbwe.dts
rename to arch/arm/boot/dts/ox810se-wd-mbwe.dts
diff --git a/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts b/arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
similarity index 100%
rename from arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
rename to arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
-- 
2.15.1
