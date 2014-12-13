From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Sat, 13 Dec 2014 02:46:45 +0100
Subject: [PATCH 0/3] removing of some unused/unsupported dts entries
Message-ID: <cover.1418434448.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have found some dts entries which are not evaluated by the drivers. This
patch remove this entries from the dts files.
Jason has mentioned I should CC: Thomas, Marc and him self to this mails.

thanks and best regards,
Silvio


Silvio Fricke (3):
  ARM: mx5: dts: remove unused irq-trigger entry
  ARM: tegra: dts: remove unused irq-trigger entry
  ARM: SPEAr: dts: remove unused irq-trigger, id and block entries

 arch/arm/boot/dts/imx53-m53.dtsi      | 1 -
 arch/arm/boot/dts/spear1310-evb.dts   | 1 -
 arch/arm/boot/dts/spear1340-evb.dts   | 2 --
 arch/arm/boot/dts/spear320-hmi.dts    | 3 ---
 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 -
 5 files changed, 8 deletions(-)

-- 
2.1.3
