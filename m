From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 Oct 2017 17:39:38 +0200
Subject: [PATCH 0/2] ARM64: dts: meson-gx: cleanup uarts nodes
Message-ID: <1507736380-21019-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the switch to documented uart bindings, old compatible and clocks
were left for simplicity.

These patches finally cleans these up.

Neil Armstrong (2):
  ARM64: dts: meson-gx: remove unnecessary clocks properties
  ARM64: dts: meson-gx: remove unnecessary uart compatible

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.7.4
