From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 18 Apr 2016 10:16:06 +0800
Subject: [PATCH v2 1/2] Documentation: fsl-quadspi: Add fsl, ls1043a-qspi
 compatible string
In-Reply-To: <20160414161206.GA9978@rob-hp-laptop>
References: <1460542107-45807-1-git-send-email-yao.yuan@freescale.com>
 <1460542107-45807-2-git-send-email-yao.yuan@freescale.com>
 <20160414161206.GA9978@rob-hp-laptop>
Message-ID: <20160418021606.GT28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:12:06AM -0500, Rob Herring wrote:
> On Wed, Apr 13, 2016 at 06:08:26PM +0800, Yuan Yao wrote:
> > From: Yuan Yao <yao.yuan@nxp.com>
> > 
> > new compatible string: "fsl,ls1043a-qspi".
> > 
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> There's a typo in the compatible string in the subject. Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Fixed the typo (the space in the middle of compatible string), and
applied both patches.

Shawn
