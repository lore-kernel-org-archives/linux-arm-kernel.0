From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Mon, 28 Sep 2015 02:48:12 +0000
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
Message-ID: <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

Could you tell me how to get the detailed Layerscape route map.
I am not sure that only Layerscape 1 series use the similar GIC and SCFG to implement MSI.
I am even not sure if ls1043 belongs Layerscape 1 series. 

Could anyone tell me how to get the MSI route map?

Thanks,
Minghuan

 
> -----Original Message-----
> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com] On Behalf Of Li Yang
> Sent: Saturday, September 26, 2015 12:37 AM
> To: Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org; Jason Cooper
> <jason@lakedaemon.net>; Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>;
> Yoder Stuart-B08248 <stuart.yoder@freescale.com>; Zang Roy-R61911
> <tie-fei.zang@freescale.com>; Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
> support
> 
> On Thu, Sep 17, 2015 at 4:28 AM, Minghuan Lian
> <Minghuan.Lian@freescale.com> wrote:
> > Some SoC of Freescale Layerscape provide a kind of MSI controller
> > which uses two registers MSIIR and MSIR to support 32 MSI interrupts
> > for each PCIe controller. The patch is to support it.
> 
> If this only applies to LS1 please say explicitly that this is only for Layerscape 1
> series in the title, commit message and code comment.
> It seems that we are not delivering a consistent message here.
> Although I don't even know if associating this with LS 1 series will stay true in
> the future.  Maybe we should instead mention it as MSI controller with an old
> GIC?
> 
> 
> Regards,
> Leo
