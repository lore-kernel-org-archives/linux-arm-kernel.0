From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 09:18:17 +0800
Subject: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <20161114071308.GL3310@dragon>
References: <1478715118-12848-1-git-send-email-harninder.rai@nxp.com>
 <20161114071308.GL3310@dragon>
Message-ID: <20161115011815.GS3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 03:13:10PM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 6602718..39db645 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -1,3 +1,6 @@
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
> 
> It seems that the patch is not generated against mainline kernel.  We do
> not have fsl-ls1046a-qds.dtb target in mainline kernel.

Sorry, forgot that we just added it in this development cycle.

Shawn
