From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:28:56 -0500
Subject: [PATCH v4 2/5] dt-bindings: phy-rockchip-inno-usb2: add
 rockchip,usbgrf property
In-Reply-To: <1502438871-9482-3-git-send-email-frank.wang@rock-chips.com>
References: <1502438871-9482-1-git-send-email-frank.wang@rock-chips.com>
 <1502438871-9482-3-git-send-email-frank.wang@rock-chips.com>
Message-ID: <20170817152856.hg27hbmfxgatyzve@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 04:07:48PM +0800, Frank Wang wrote:
> Add rockchip,usbgrf property to support the registers of usb-phy
> that are distributed in grf and usbgrf on some special Rockchip
> SoCs (e.g RV1108).
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
