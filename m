From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 19:14:16 -0500
Subject: [PATCH 2/2] Documentation: fsl: dspi: Add a compatible string
 for ls1088a DSPI
In-Reply-To: <20171101034015.41114-3-Zhiqiang.Hou@nxp.com>
References: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
 <20171101034015.41114-3-Zhiqiang.Hou@nxp.com>
Message-ID: <20171102001416.6etwlhfauu7auc7p@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 11:40:15AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add a new compatible string "fsl,ls1088a-dspi".
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
>  1 file changed, 1 insertion(+)

"dt-bindings: spi: " for the subject. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
