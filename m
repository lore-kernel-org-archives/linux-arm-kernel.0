From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Jul 2018 23:08:06 +0200
Subject: [GIT PULL] pxa-dt for v4.19
Message-ID: <87r2k89n7t.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.19 device-tree, with a couple fixes from
Daniel for pxa3xx.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.19

for you to fetch changes up to 49e414c32053554736c421b1ac5b645f5c73e879:

  arm: dts: pxa3xx: Add ssp ports to pxa3xx device tree (2018-06-29 22:23:44 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - pxa3xx fixes and updates

----------------------------------------------------------------
Daniel Mack (3):
      ARM: dts: pxa: add label to lcd controller node
      arm: dts: pxa3xx: provide correct clk-names property for nand controller node
      arm: dts: pxa3xx: Add ssp ports to pxa3xx device tree

 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |  8 ++----
 arch/arm/boot/dts/pxa2xx.dtsi                      |  2 +-
 arch/arm/boot/dts/pxa3xx.dtsi                      | 33 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

-- 
Robert
