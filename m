From: aalonso@freescale.com (Alonso Adrian)
Date: Thu, 23 Jul 2015 19:34:56 +0000
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <20150717033429.GC12927@tiger>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
 <20150715072307.GM4119@tiger>
 <BN3PR03MB1509DFB6A1513A23C48476CFA89A0@BN3PR03MB1509.namprd03.prod.outlook.com>
 <20150716155034.GN4119@tiger>
 <CAHrpEqQv4uzQ7+EnFV7rwnhAzaSnEfwoo+_SFRsvMh-nR3PdBw@mail.gmail.com>
 <BN3PR03MB15095AD84AD5738B142F6F8CA8990@BN3PR03MB1509.namprd03.prod.outlook.com>
 <20150717033429.GC12927@tiger>
Message-ID: <BN3PR03MB150926F2FABADED18630B27CA8820@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

The approach you mention is already supported in FSL kernel tree see
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.14.38_6ul7d_beta&id=a37ea06ddccbefb8660af0ac259c30d98540bdc2

I will rework and proposed a new patch series soon.

Thanks for your reviews :)

Regards
Adrian

> -----Original Message-----
> From: linux-gpio-owner at vger.kernel.org [mailto:linux-gpio-
> owner at vger.kernel.org] On Behalf Of Shawn Guo
> Sent: Thursday, July 16, 2015 10:34 PM
> To: Alonso Lazcano Adrian-B38018
> Cc: Zhi Li; devicetree at vger.kernel.org; Li Frank-B20596; Garg Nitin-B37173;
> linus.walleij at linaro.org; linux-gpio at vger.kernel.org; robh+dt at kernel.org;
> shawn.guo at linaro.org; Huang Yongcai-B20788; linux-arm-
> kernel at lists.infradead.org; Gong Yibin-B38343
> Subject: Re: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
> lpsr
> 
> On Thu, Jul 16, 2015 at 08:39:33PM +0000, Alonso Adrian wrote:
> > Hi All,
> >
> > I will sent a new patch series including documentation for pad group
> > id encoding in
> > Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> >
> > Thanks for your comments :)
> 
> Do not get me wrong.  The problem with the patch is not merely missing the
> document update.
> 
> Shawn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
