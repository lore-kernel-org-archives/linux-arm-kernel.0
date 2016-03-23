From: carlo@caione.org (Carlo Caione)
Date: Wed, 23 Mar 2016 10:13:58 +0100
Subject: [PATCH v3 0/2] Split pinctrl device for Meson8 / Meson8b and update
 docs
Message-ID: <1458724440-32228-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

With http://www.spinics.net/lists/devicetree/msg116771.html we split / refactor
the pinctrl driver to have two different pinctrl devices for each bus.

Unfortunately these two patches still haven't found their way to mainline.
Reposting them as standalone patchset. Hopefully they can be ACKed as soon as
possible.

Carlo Caione (2):
  ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b
  documentation: Fix pinctrl documentation for Meson8 / Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 +++------------
 arch/arm/boot/dts/meson8.dtsi                      | 57 ++++++++++++----------
 arch/arm/boot/dts/meson8b.dtsi                     | 12 ++++-
 3 files changed, 49 insertions(+), 58 deletions(-)

-- 
2.5.0
