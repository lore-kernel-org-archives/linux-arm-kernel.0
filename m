From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:58:00 +0200
Subject: [PATCH v5 1/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <1403177830-28595-1-git-send-email-thierry.reding@gmail.com>
References: <1403177830-28595-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140711125759.GB10744@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 01:37:07PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This patch adds the device tree binding documentation for the XUSB pad
> controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
> capabilities.
> 
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - drop unneeded #address-cells = <0> and #size-cells = <0>
> 
> Changes in v2:
> - move header file to this patch and refer to it in the binding
> - update example to match the latest binding
> 
>  .../pinctrl/nvidia,tegra124-xusb-padctl.txt        | 127 +++++++++++++++++++++
>  include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h   |   7 ++
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h

Patches 1 and 2 applied to the for-3.17/xusb-padctl branch with Linus'
Acked-by.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/6cf2c4fd/attachment.sig>
