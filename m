From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Feb 2018 01:07:29 +0100
Subject: [PATCH v3 2/6] dt-bindings: phy-rockchip-typec: deprecate some
 register properties.
In-Reply-To: <20180216120956.19034-2-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-2-enric.balletbo@collabora.com>
Message-ID: <5593793.vhYJ9g2msI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Februar 2018, 13:09:52 CET schrieb Enric Balletbo i Serra:
> As now the following register properties are in the driver, document as
> deprecated these properties and recommend to not use them on new bindings.
> 
> The deprecated properties are:
> 
> - rockchip,typec-conn-dir : the register of type-c connector direction
> - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2
>                            enable control.
> - rockchip,external-psm : the register of type-c phy external psm clock
>                           selection.
> - rockchip,pipe-status : the register of type-c phy pipe status.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
