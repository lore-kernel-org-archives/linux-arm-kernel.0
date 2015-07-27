From: claudiu.manoil@freescale.com (Manoil Claudiu)
Date: Mon, 27 Jul 2015 16:09:26 +0000
Subject: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and
 eTSEC2
In-Reply-To: <20150727142816.GP12927@tiger>
References: <20150713133138.GO23464@tiger>
 <1436888777-29742-1-git-send-email-claudiu.manoil@freescale.com>
 <20150727142816.GP12927@tiger>
Message-ID: <BY2PR0301MB07278CDB98082971F6094FD19C8E0@BY2PR0301MB0727.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, July 27, 2015 5:28 PM
> To: Manoil Claudiu-B08782
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; shawn.guo at linaro.org; Wang Huan-B18965
> Subject: Re: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and
> eTSEC2
> 
[...]
> >
> >  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  6 +-
> 
> Bindings doc should be a separate patch reviewed by device tree
> maintainers.
> 
> >  arch/arm/boot/dts/ls1021a-qds.dts                  | 20 +++++
> >  arch/arm/boot/dts/ls1021a-twr.dts                  | 20 +++++
> >  arch/arm/boot/dts/ls1021a.dtsi                     | 92
> ++++++++++++++++++++++
> 
> Please separate soc level dts changes from board level changes.
> 

Ok, will break this in 3 patches (soc, boards, bindings), trimmed down as much as possible,
with remaining findings addressed.  Thanks.
