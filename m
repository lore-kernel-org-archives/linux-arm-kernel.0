From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Jun 2016 20:41:34 -0500
Subject: [PATCH 1/3] dt-bindings: phy: Fix description of Tegra210 PHY
 nodes
In-Reply-To: <1467198453-23406-2-git-send-email-jonathanh@nvidia.com>
References: <1467198453-23406-1-git-send-email-jonathanh@nvidia.com>
 <1467198453-23406-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160701014134.GA26253@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 12:07:31PM +0100, Jon Hunter wrote:
> The dt-binding document for the Tegra XUSB pad controller states that
> 'utmi' is one of the valid choices for the Tegra210 PHY node names and
> has child lanes named, 'utmi-0', 'utmi-1', 'utmi-2' and 'utmi-3'.
> However, neither the XUSB pad controller PHY driver or the actual
> Tegra210 binding for the XUSB pad controller use these names. Instead
> both the driver and binding use the node name 'usb2' and for the child
> lanes use the names 'usb2-0', 'usb2-1', 'usb2-2' and 'usb2-3'. Given
> that the driver and binding are consistent with the naming, up date the
> dt-binding documentation to match.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
