From: scottwood@freescale.com (Scott Wood)
Date: Fri, 2 Oct 2015 18:57:42 -0500
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
 <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
Message-ID: <1443830262.5336.216.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-28 at 17:19 -0500, Li Yang wrote:
> On Sun, Sep 27, 2015 at 9:48 PM, Lian M.H. <Minghuan.Lian@freescale.com> 
> wrote:
> > Hi Leo,
> > 
> > Could you tell me how to get the detailed Layerscape route map.
> > I am not sure that only Layerscape 1 series use the similar GIC and SCFG 
> > to implement MSI.
> > I am even not sure if ls1043 belongs Layerscape 1 series.
> > 
> > Could anyone tell me how to get the MSI route map?
> 
> MSI shouldn't be the key feature to determine the naming of an SoC.
> So I don't think anyone can tell if all 1 series in the future will
> use this approach. 

In the past the only thing the first number of a QorIQ chip name has meant is 
an approximate positioning on the low-end/high-end spectrum.  It cannot be 
used for grouping chips according to anything that software cares about.

> Probably it will be more generic to name it "fsl,scfg-msi"

Better would have a specific SoC in the name.

-Scott
