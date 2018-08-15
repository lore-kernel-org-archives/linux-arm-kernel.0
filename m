From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Aug 2018 14:26:31 -0600
Subject: [PATCH v4 4/6] dt-bindings: imx6q-pcie: Add turnoff reset for
 imx7d
In-Reply-To: <e4e35d89f8e393cd291cb612a95faf1653a26f9b.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <e4e35d89f8e393cd291cb612a95faf1653a26f9b.1534264292.git.leonard.crestez@nxp.com>
Message-ID: <20180815202630.GA18952@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Aug 2018 19:50:18 +0300, Leonard Crestez wrote:
> This is documented as "required" but won't be present in old dtbs.
> 
> These resets are also present on other imx chips but right now only
> imx7d implements them through the reset controller subsystem.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
