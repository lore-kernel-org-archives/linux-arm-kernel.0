From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 19:09:46 +0800
Subject: [PATCH RESEND 0/8] {arm|arm64}: berlin: add watchdog support
Message-ID: <1447672194-483-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Marvell berlin SoCs, there are watchdogs which are compatible with the
snps,dw-wdt driver. This series try to add watchdog support for them.

Jisheng Zhang (8):
  arm: dts: berlin2q: add watchdog nodes
  arm: dts: berlin2cd: add watchdog nodes
  arm: dts: berlin2: add watchdog nodes
  arm64: dts: berlin4ct: add watchdog nodes
  arm: dts: berlin: enable wdt0 on Sony NSZ-GS7
  ARM: dts: berlin: enable wdt0 on the Google Chromecast
  arm: dts: berlin: enable wdt0 on the Marvell BG2Q DMP
  arm64: dts: berlin: enable wdt0 on the Marvell BG4CT STB board

 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  2 ++
 arch/arm/boot/dts/berlin2.dtsi                    | 24 +++++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  2 ++
 arch/arm/boot/dts/berlin2cd.dtsi                  | 24 +++++++++++++++++++++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        |  4 ++++
 arch/arm/boot/dts/berlin2q.dtsi                   | 24 +++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts     |  4 ++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi        | 24 +++++++++++++++++++++++
 8 files changed, 108 insertions(+)

-- 
2.6.1
