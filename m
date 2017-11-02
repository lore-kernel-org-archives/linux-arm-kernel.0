From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 2 Nov 2017 03:12:22 +0000
Subject: [PATCH 2/2] Documentation: fsl: dspi: Add a compatible string for
 ls1088a DSPI
In-Reply-To: <20171102001416.6etwlhfauu7auc7p@rob-hp-laptop>
References: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
 <20171101034015.41114-3-Zhiqiang.Hou@nxp.com>
 <20171102001416.6etwlhfauu7auc7p@rob-hp-laptop>
Message-ID: <VI1PR0402MB27823B7E70356968D2381FBE845C0@VI1PR0402MB2782.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks a lot for the ack!

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 2017?11?2? 8:14
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-spi at vger.kernel.org; broonie at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>
> Subject: Re: [PATCH 2/2] Documentation: fsl: dspi: Add a compatible string for
> ls1088a DSPI
> 
> On Wed, Nov 01, 2017 at 11:40:15AM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add a new compatible string "fsl,ls1088a-dspi".
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> "dt-bindings: spi: " for the subject. Otherwise,

I'll recompose the subject in next version.

> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
Zhiqiang
