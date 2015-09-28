From: leoli@freescale.com (Li Yang)
Date: Mon, 28 Sep 2015 17:19:17 -0500
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
 <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
Message-ID: <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 9:48 PM, Lian M.H. <Minghuan.Lian@freescale.com> wrote:
> Hi Leo,
>
> Could you tell me how to get the detailed Layerscape route map.
> I am not sure that only Layerscape 1 series use the similar GIC and SCFG to implement MSI.
> I am even not sure if ls1043 belongs Layerscape 1 series.
>
> Could anyone tell me how to get the MSI route map?

MSI shouldn't be the key feature to determine the naming of an SoC.
So I don't think anyone can tell if all 1 series in the future will
use this approach.  Probably it will be more generic to name it
"fsl,scfg-msi"

Regards,
Leo
