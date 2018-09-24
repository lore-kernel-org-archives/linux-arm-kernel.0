From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Sep 2018 15:47:12 +0200
Subject: [PATCH 0/3] add dwc2 support for px30
In-Reply-To: <20180802130133.4898-1-heiko@sntech.de>
References: <20180802130133.4898-1-heiko@sntech.de>
Message-ID: <102522978.rGKrA9VWk8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 2. August 2018, 15:01:30 CEST schrieb Heiko Stuebner:
> This is split out from the series adding the px30 support, due to
> the dwc2 binding change not having landed yet in a maintainer tree.
> 
> The Acked binding change should go through some usb tree, while
> I'll pick up the dts changes once that has happened.
> 
> The binding itself is unchanged.
> 
> 
> Heiko Stuebner (2):
>   arm64: dts: rockchip: add dwc2 otg controller on px30
>   arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb
> 
> Liang Chen (1):
>   dt-bindings: usb: dwc2: add description for px30

applied all 3 patches for 4.20 now.
