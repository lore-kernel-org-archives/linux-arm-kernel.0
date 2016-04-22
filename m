From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Apr 2016 15:56:27 +0200
Subject: [PATCH] ARM: dts: rockchip: move rk3288 edp phy under the GRF
In-Reply-To: <1640976.sZtsTTlDpl@diego>
References: <1640976.sZtsTTlDpl@diego>
Message-ID: <4275673.EbRsbqkhH8@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 16. April 2016, 02:49:14 schrieb Heiko St?bner:
> The edp-phy control is a part of the General Register Files and
> with a recent patch in 4.6 the phy driver can now also handle this
> correctly, so move the dts node under the GRF as well.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

the change in the phy-driver has made it into Greg's usb tree as fix for 4.6, 
so I've picked this patch for 4.7 now.
