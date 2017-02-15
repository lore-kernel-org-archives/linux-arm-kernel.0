From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 17:04:15 -0600
Subject: [PATCH for-4.11 2/2] Revert "dt-bindings: phy: Add documentation
 for NSP USB3 PHY"
In-Reply-To: <20170208233023.31922-2-zajec5@gmail.com>
References: <20170208233023.31922-1-zajec5@gmail.com>
 <20170208233023.31922-2-zajec5@gmail.com>
Message-ID: <20170215230415.3sap4vr3llazunyd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 12:30:23AM +0100, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> This reverts commit c8ca631f9480 ("dt-bindings: phy: Add documentation
> for NSP USB3 PHY") to match reverting commit adding the new PHY driver.
> Please note we revert this commit before it reached stable release.
> 
> If new compatible string is needed it should be added to the existing
> bcm-ns-usb3-phy.txt which already describes this PHY.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/phy/brcm,nsp-usb3-phy.txt  | 39 ----------------------
>  1 file changed, 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt

Acked-by: Rob Herring <robh@kernel.org> 
