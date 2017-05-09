From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Tue, 9 May 2017 02:51:54 +0000
Subject: [v2, 1/5] mmc: dt: add compatible into eSDHC required properties
In-Reply-To: <20170508163626.q2tyiat2zmo7taju@rob-hp-laptop>
References: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
 <1493894940-47452-2-git-send-email-yangbo.lu@nxp.com>
 <20170505023651.GW18578@dragon>
 <DB6PR0401MB2536CB3661070921AEA0C5B6F8EB0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20170508163626.q2tyiat2zmo7taju@rob-hp-laptop>
Message-ID: <DB6PR0401MB25365E54D191D19158202CFDF8EF0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, May 09, 2017 12:36 AM
> To: Y.B. Lu
> Cc: Shawn Guo; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; ulf.hansson at linaro.org; Catalin Marinas;
> Harninder Rai; Xiaobo Xie
> Subject: Re: [v2, 1/5] mmc: dt: add compatible into eSDHC required
> properties
> 
> On Fri, May 05, 2017 at 03:01:04AM +0000, Y.B. Lu wrote:
> > Hi Shawn,
> >
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > Sent: Friday, May 05, 2017 10:37 AM
> > > To: Y.B. Lu
> > > Cc: devicetree at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org;
> > > ulf.hansson at linaro.org; Rob Herring; Catalin Marinas; Harninder Rai;
> > > Xiaobo Xie
> > > Subject: Re: [v2, 1/5] mmc: dt: add compatible into eSDHC required
> > > properties
> > >
> > > On Thu, May 04, 2017 at 06:48:56PM +0800, Yangbo Lu wrote:
> > > > This patch is to add compatible into eSDHC required properties.
> > > >
> > > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > > ---
> > > > Changes for v2:
> > > > 	- Added this patch.
> > > > ---
> > > >  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > > b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > > index dedfb02..b04b248 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > > +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > > @@ -7,6 +7,7 @@ This file documents differences between the core
> > > > properties described  by mmc.txt and the properties used by the
> > > > sdhci-
> > > esdhc driver.
> > > >
> > > >  Required properties:
> > > > +  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
> > >
> > > I think either supported <chip> or the compatible should be listed
> > > explicitly.
> > >
> >
> > [Lu Yangbo-B47093] I think the reason we use <chip> is to avoid listing
> too much chips, and to avoid doc updating if new chips are added.
> > The checkpatch script also had considered that.
> >
> > Currently there're about 20 platforms with "fsl,<chip>-esdhc"
> compatible in kernel dts.
> 
> Yes, but it's generally preferred to list possible values of <chip>.
> 

[Lu Yangbo-B47093] Ok, thanks for your suggestions, Rob and Shawn.
I will send out the new version soon :)

> Rob
