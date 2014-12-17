From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Dec 2014 18:18:11 +0100
Subject: [PATCH v2 00/13] sun6i: Add A31s and ir support
Message-ID: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my patch series to add sun6i A31s and ir support.

Changes in v2:

-"pinctrl: sun6i: Add some missing functions, fix i2c3 muxing":
 -Drop the changes to the muxing of i2c3 this was based on                 
  "A31s Datasheet v1.40.pdf", but all other A31 related info puts them at the
  pins where we already have them, so leave this as is
-"pinctrl: sun6i: Add A31s pinctrl support"
 -Sync i2c3 muxing with v2 of "pinctrl: sun6i: Add some missing functions"
 -Add myself to the copyright header
-"clk: sunxi: Make the mod0 clk driver also a platform driver"
 -New patch in v2 of the set
-"mfd: sun6i-prcm: Add support for the ir-clk"
 -New patch in v2 of the set
-"ARM: dts: sun6i: Add sun6i-a31s.dtsi"
 -include sun6i-a31.dtsi and override the pinctrl compatible, rather then
  copying everything
-"ARM: dts: sun6i: Add ir_clk node"
 -Use allwinner,sun4i-a10-mod0-clk as compatible, rather then a prcm
  specific compatible

Please queue this up for 3.20 .

Thanks,

Hans
