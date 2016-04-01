From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:14:40 -0500
Subject: [PATCH 1/2] Documentation: fsl-quadspi: Add fsl, ls1043a-qspi
 compatible string
In-Reply-To: <1459406701-40993-2-git-send-email-yao.yuan@freescale.com>
References: <1459406701-40993-1-git-send-email-yao.yuan@freescale.com>
 <1459406701-40993-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160401171440.GA7522@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:45:00PM +0800, Yuan Yao wrote:
> From: Yuan Yao <yao.yuan@nxp.com>
> 
> new compatible string: "fsl,ls1043a-qspi".
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

There's a typo in the compatible string in the subject, otherwise:

Acked-by: Rob Herring <robh@kernel.org>
