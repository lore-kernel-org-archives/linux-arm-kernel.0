From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 11:12:06 -0500
Subject: [PATCH v2 1/2] Documentation: fsl-quadspi: Add fsl, ls1043a-qspi
 compatible string
In-Reply-To: <1460542107-45807-2-git-send-email-yao.yuan@freescale.com>
References: <1460542107-45807-1-git-send-email-yao.yuan@freescale.com>
 <1460542107-45807-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160414161206.GA9978@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 06:08:26PM +0800, Yuan Yao wrote:
> From: Yuan Yao <yao.yuan@nxp.com>
> 
> new compatible string: "fsl,ls1043a-qspi".
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

There's a typo in the compatible string in the subject. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
