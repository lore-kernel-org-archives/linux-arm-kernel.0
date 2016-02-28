From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Feb 2016 14:49:12 +0800
Subject: ARM: dts: imx6ul: add more functionality to i.MX6UL
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160228064912.GH22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 11:08:53AM +0100, Lothar Wa?mann wrote:
> This patchset adds more functionality to the i.MX6UL machines.
> 
> The first three patches are cleanup patches with no functional changes
> intended.
> The other patches make various subsystems functional.
> 
> ARM: dts: imx6ul: whitespace cleanup; no functional

This has been applied from another series.

> ARM: dts: imx6ul: move tsc node to appropriate place
> ARM: dts: imx6ul: move dt-bindings/input/input.h
> ARM: dts: imx6ul: specify proper clocks for GPT node
> ARM: dts: imx6ul: specify proper clocks for the PWM
> ARM: dts: imx6ul: disable PWMs by default
> ARM: dts: imx6ul: add pwm[1-4] nodes
> ARM: dts: imx6ul: add sdma support
> ARM: dts: imx6ul: add flexcan support
> ARM: dts: imx6ul: add sai support
> ARM: dts: imx6ul: add lcdif support
> ARM: dts: imx6ul: add gpmi support

Just applied the above.

> clk: imx: whitespace cleanup; no functional change
> clk: imx: add kpp clock for i.MX6UL

These two have been applied from a separate series.

> ARM: dts: imx6ul: add kpp support

It was just applied.

Shawn

> ARM: dts: imx6ul: add support for Ka-Ro electronics TX6UL module
