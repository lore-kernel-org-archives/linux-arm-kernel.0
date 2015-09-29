From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Tue, 29 Sep 2015 02:57:55 +0000
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
 <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
Message-ID: <DM2PR0301MB06409BD76B841E3AA89E74DCE24E0@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

Thanks for your advice.
"fsl,scfg-msi" is better, I use it in next version.

Thanks,
Minghuan

> -----Original Message-----
> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com] On Behalf Of Li Yang
> Sent: Tuesday, September 29, 2015 6:19 AM
> To: Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>
> Cc: Jason Cooper <jason@lakedaemon.net>; Yoder Stuart-B08248
> <stuart.yoder@freescale.com>; Thomas Gleixner <tglx@linutronix.de>; Zang
> Roy-R61911 <tie-fei.zang@freescale.com>; Hu Mingkai-B21284
> <Mingkai.Hu@freescale.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
> support
> 
> On Sun, Sep 27, 2015 at 9:48 PM, Lian M.H. <Minghuan.Lian@freescale.com>
> wrote:
> > Hi Leo,
> >
> > Could you tell me how to get the detailed Layerscape route map.
> > I am not sure that only Layerscape 1 series use the similar GIC and SCFG to
> implement MSI.
> > I am even not sure if ls1043 belongs Layerscape 1 series.
> >
> > Could anyone tell me how to get the MSI route map?
> 
> MSI shouldn't be the key feature to determine the naming of an SoC.
> So I don't think anyone can tell if all 1 series in the future will use this approach.
> Probably it will be more generic to name it "fsl,scfg-msi"
> 
> Regards,
> Leo
