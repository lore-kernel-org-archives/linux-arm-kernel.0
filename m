From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Jul 2018 15:03:14 +0200
Subject: [PATCH] usb: dwc3: rockchip: Fix PHY documentation links.
In-Reply-To: <20180710125848.15915-1-enric.balletbo@collabora.com>
References: <20180710125848.15915-1-enric.balletbo@collabora.com>
Message-ID: <1651148.X0ZVfyzq5n@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. Juli 2018, 14:58:48 CEST schrieb Enric Balletbo i Serra:
> Commit 34962fb8070c ("docs: Fix more broken references") replaced the
> broken reference to rockchip,dwc3-usb-phy.txt binding for the Qualcomm
> DWC3 binding (qcom-dwc3-usb-phy.txt). That's wrong, so replace that
> reference for the correct ones.
> 
> Fixes: 34962fb8070c ("docs: Fix more broken references")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
