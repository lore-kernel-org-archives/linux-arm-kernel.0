From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Jul 2014 02:00:47 -0700
Subject: [PATCH v2 0/7] arm: dts: oma3-gta04: Various updates
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <20140723090047.GD22006@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [140722 12:32]:
> Following patchset add various improvements to gta04 devicetree.
> 
> Changes from v1:
> - added description to all patches
> 
> Marek Belisko (7):
>   arm: dts: omap3-gta04: Add nand support
>   arm: dts: omap3-gta04: Fix magnetometer model
>   arm: dts: omap3-gta04: Add wifi reset node
>   arm: dts: omap3-gta04: Move spi gpio pins to pmx_core2
>   arm: dts: omap3-gta04: Add USB host support
>   arm: dts: omap3-gta04: Add display alias
>   arm: dts: omap3-gta04: Add twl4030 regulators parameters
> 
>  arch/arm/boot/dts/omap3-gta04.dts | 150 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 145 insertions(+), 5 deletions(-)

Applying into omap-for-v3.17/dt thanks.

Tony
