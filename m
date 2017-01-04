From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  4 Jan 2017 10:30:44 +0100
Subject: [PATCH 0/2] ARM: dts: oxnas: Update with dt-bindings
Message-ID: <20170104093046.12428-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchsets updates the OX810SE and OX820 dtsi with the reset and
clock dt-bindings includes then replaces magic values with bindings
defines.

Neil Armstrong (2):
  ARM: dts: OX810: Update with dt-bindings includes
  ARM: dts: OX820: Update with dt-bindings includes

 arch/arm/boot/dts/ox810se.dtsi | 10 ++++++----
 arch/arm/boot/dts/ox820.dtsi   | 14 ++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.7.0
