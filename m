From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 16 Jan 2015 18:37:45 +0100
Subject: [GIT PULL] ARM: STi: DT changes for v3.20, round 1
Message-ID: <54B94C69.5050809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v3.20.

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.20-1

for you to fetch changes up to b26373c0da982f8a29406f10db39e287c1f0696b:

   ARM: DT: STi: STiH407: Add DT node for MiPHY28lp (2015-01-16 12:57:12 
+0100)

----------------------------------------------------------------
STi DT updates for v3.20, round 1.

Highlights:
-----------
  - Add USB support for STiH410 & STiH407
  - Add DRM DT nodes for STiH410 & STiH407
  - Add STiH418 SoC support
  - Add DT nodes for MiPHY28lp PHY

----------------------------------------------------------------
Gabriel FERNANDEZ (3):
       ARM: DT: STiH407: Add DRM dt nodes
       ARM: DT: STiH410: Add DRM dt nodes
       ARM: DT: STi: STiH407: Add DT node for MiPHY28lp

Maxime COQUELIN (2):
       ARM: dts: Add STiH418 SoC support
       ARM: dts: STiH418: Add B2199 board support

Peter Griffin (3):
       ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
       ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
       ARM: STi: DT: STiH410: Add DT nodes for the ehci and ohci usb 
controllers.

  arch/arm/boot/dts/Makefile               |   3 +-
  arch/arm/boot/dts/stih407-b2120.dts      |   3 +-
  arch/arm/boot/dts/stih407-family.dtsi    |  62 ++++++
  arch/arm/boot/dts/stih407.dtsi           | 151 ++++++++++++++
  arch/arm/boot/dts/stih410.dtsi           | 208 ++++++++++++++++++
  arch/arm/boot/dts/stih418-b2199.dts      |  78 +++++++
  arch/arm/boot/dts/stih418-clock.dtsi     | 348 
+++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stih418.dtsi           |  99 +++++++++
  arch/arm/boot/dts/stihxxx-b2120.dtsi     |  13 +-
  include/dt-bindings/clock/stih418-clks.h |  34 +++
  10 files changed, 995 insertions(+), 4 deletions(-)
  create mode 100644 arch/arm/boot/dts/stih407.dtsi
  create mode 100644 arch/arm/boot/dts/stih418-b2199.dts
  create mode 100644 arch/arm/boot/dts/stih418-clock.dtsi
  create mode 100644 arch/arm/boot/dts/stih418.dtsi
  create mode 100644 include/dt-bindings/clock/stih418-clks.h
