From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 15:06:57 +0100
Subject: [PATCH v3 6/8] ARM: dts: rockchip: add clock-cells for usb phy
 nodes
In-Reply-To: <1447968149-10979-7-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
 <1447968149-10979-7-git-send-email-heiko@sntech.de>
Message-ID: <2533572.i0vRkUzAgm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 19. November 2015, 22:22:27 schrieb Heiko Stuebner:
> Add the #clock-cells properties for the usbphy nodes as they
> provide the pll-clocks now.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

applied to my dts32 branch for 4.6 with Mike's Review-tag from v1
