From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 14:02:43 -0600
Subject: [PATCH v3 2/6] dt-bindings: phy-rockchip-typec: deprecate some
 register properties.
In-Reply-To: <20180216120956.19034-2-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-2-enric.balletbo@collabora.com>
Message-ID: <20180219200243.mluxhx35wimphydc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 01:09:52PM +0100, Enric Balletbo i Serra wrote:
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
> ---
> Changes since v2:
> - Apply the nit suggested by Heiko Stuebner.
> Changes since v1:
> - This patch is new on these series and is just a documentation update
>   due patch [1/6]
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 33 +++++-----------------
>  1 file changed, 7 insertions(+), 26 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
