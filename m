From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Jul 2018 08:17:05 -0600
Subject: [PATCH] usb: dwc3: rockchip: Fix PHY documentation links.
In-Reply-To: <20180710125848.15915-1-enric.balletbo@collabora.com>
References: <20180710125848.15915-1-enric.balletbo@collabora.com>
Message-ID: <20180720141705.GA30482@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 02:58:48PM +0200, Enric Balletbo i Serra wrote:
> Commit 34962fb8070c ("docs: Fix more broken references") replaced the
> broken reference to rockchip,dwc3-usb-phy.txt binding for the Qualcomm
> DWC3 binding (qcom-dwc3-usb-phy.txt). That's wrong, so replace that
> reference for the correct ones.
> 
> Fixes: 34962fb8070c ("docs: Fix more broken references")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied.

Rob
