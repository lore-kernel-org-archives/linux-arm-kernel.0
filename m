From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:22:00 -0700
Subject: [PATCH] multi_v7_defconfig: make Rockchip usb2-phy built-in
In-Reply-To: <20170403102212.6802-1-heiko@sntech.de>
References: <20170403102212.6802-1-heiko@sntech.de>
Message-ID: <20170419122200.GC17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 12:22:12PM +0200, Heiko Stuebner wrote:
> The phy is necessary for the dwc2 controllers driving the usb ports
> on all arm32 Rockchip socs. Both the dwc2 as well as usb downstream
> drivers (mass-storage as well as usb networking) are already built-in,
> so only the phy is missing to allow booting from usb-devices without
> to much hassle.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Ideally to be applied directly to some armsoc defconfig branch.

Merged, thanks!

-Olof
