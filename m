From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jul 2015 03:59:31 -0700
Subject: [PATCH 1/2] ARM: dts: Add support for phyCORE-AM335x SoM
In-Reply-To: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
References: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20150721105930.GB17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [150716 01:36]:
> phyCORE-AM335x is a SoM (System on Module) containing
> a AM335x SOC. The module can be connected to different
> carrier boards.
> 
> Some hardware parts are configurable on the phyCORE-AM335x.
> So they are disabled on default in this som dtsi file.
> They will be enabled in the board dts files, when populated.
> 
> * RAM up to 1GiB
> * PMIC
> * NAND flash up to 1GiB
> * Eth PHY on SOM: 1x RMII
> * SPI NOR flash 8MiB (optional)
> * i2c RTC (optional)
> * i2c EEPROM 4kiB (optional)

Applying both into omap-for-v4.3/dt thanks.

Tony
