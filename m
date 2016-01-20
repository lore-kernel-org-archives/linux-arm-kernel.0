From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:08:53 +0100
Subject: ARM: dts: imx6ul: add more functionality to i.MX6UL
In-Reply-To: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds more functionality to the i.MX6UL machines.

The first three patches are cleanup patches with no functional changes
intended.
The other patches make various subsystems functional.

ARM: dts: imx6ul: whitespace cleanup; no functional
ARM: dts: imx6ul: move tsc node to appropriate place
ARM: dts: imx6ul: move dt-bindings/input/input.h
ARM: dts: imx6ul: specify proper clocks for GPT node
ARM: dts: imx6ul: specify proper clocks for the PWM
ARM: dts: imx6ul: disable PWMs by default
ARM: dts: imx6ul: add pwm[1-4] nodes
ARM: dts: imx6ul: add sdma support
ARM: dts: imx6ul: add flexcan support
ARM: dts: imx6ul: add sai support
ARM: dts: imx6ul: add lcdif support
ARM: dts: imx6ul: add gpmi support
clk: imx: whitespace cleanup; no functional change
clk: imx: add kpp clock for i.MX6UL
ARM: dts: imx6ul: add kpp support
ARM: dts: imx6ul: add support for Ka-Ro electronics TX6UL module

Changes vs. v1:
- added patch to implement KPP clock for i.MX6UL to prevent conflicts
  when this patch would go via a different tree.
- added board support for Ka-Ro electronics TX6UL module for the same
  reason
- added imx6ul specific compatibles as requested by Lucas Stach
