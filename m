From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 16 Dec 2017 18:01:08 +0100
Subject: [PATCH v3 5/5] arm64: dts: rockchip: add reset property for dwc3
 controllers on rk3399.
In-Reply-To: <20171215110005.7564-5-enric.balletbo@collabora.com>
References: <20171215110005.7564-1-enric.balletbo@collabora.com>
 <20171215110005.7564-5-enric.balletbo@collabora.com>
Message-ID: <2260405.eszS2niqFZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Dezember 2017, 12:00:05 CET schrieb Enric Balletbo i Serra:
> After commit '06c47e6286d usb: dwc3: of-simple: Add support to get resets
> for the device' you can add the reset property to the dwc3 node, the reset
> is required for the controller to work properly, otherwise bind / unbind
> stress testing of the USB controller on rk3399 we'd often end up with lots
> of failures that looked like this:
> 
>   phy phy-ff800000.phy.9: phy poweron failed --> -110
>   dwc3 fe900000.dwc3: failed to initialize core
>   dwc3: probe of fe900000.dwc3 failed with error -110
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied for 4.16

Thanks
Heiko
