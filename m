From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 16:01:34 -0500
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1468769937-23387-2-git-send-email-ayaka@soulik.info>
References: <5614243.tqTyZoc945@phil>
 <1468769937-23387-1-git-send-email-ayaka@soulik.info>
 <1468769937-23387-2-git-send-email-ayaka@soulik.info>
Message-ID: <20160717210134.GA25977@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 17, 2016 at 11:38:57PM +0800, Randy Li wrote:
> The Firefly RK3288 Reload is a combination Firefly rk3288 core board
> with the Reload baseboard. Add a dtsi for the Firefly rk3288 core
> which can be included into the dts for the various baseboards
> in the future and dts for Reload base board.
> 
> Currently supported are serial console, wired networking, eMMC and
> SD storage, SPFIF, IR receiver, LEDs, SDIO wifi and USB. But only
> the OTG could work on the host mode now, the other USB host can't
> work now, additional patches are required.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 304 ++++++++++++++++++++
>  arch/arm/boot/dts/rk3288-firefly-reload.dts        | 320 +++++++++++++++++++++
>  4 files changed, 629 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>  create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

Acked-by: Rob Herring <robh@kernel.org>
