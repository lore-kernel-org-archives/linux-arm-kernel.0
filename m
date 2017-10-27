From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Oct 2017 09:38:30 -0500
Subject: [PATCH v4 1/2] dt-bindings: add bindings doc for hi3798cv200
 combphy
In-Reply-To: <1509073651-23730-2-git-send-email-shawnguo@kernel.org>
References: <1509073651-23730-1-git-send-email-shawnguo@kernel.org>
 <1509073651-23730-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20171027142606.zilypg7tuxwy3fj2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 11:07:30AM +0800, Shawn Guo wrote:
> From: Jianguo Sun <sunjianguo1@huawei.com>
> 
> It adds the device tree bindings for PCIE/SATA/USB3 combo PHY found on
> HiSilicon STB SoCs.
> 
> Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/phy/phy-hi3798cv200-combphy.txt       | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> new file mode 100644
> index 000000000000..efb6cd5eae04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> @@ -0,0 +1,57 @@
> +HiSilicon STB PCIE/SATA/USB3 PHY

Please add a reference to the parent node binding.

With that,

Acked-by: Rob Herring <robh@kernel.org>
