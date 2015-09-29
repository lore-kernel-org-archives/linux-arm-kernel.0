From: leoli@freescale.com (Li Yang)
Date: Tue, 29 Sep 2015 15:10:25 -0500
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <DM2PR0301MB06409BD76B841E3AA89E74DCE24E0@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
 <DM2PR0301MB0640A0D236485867ED1B6690E24F0@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <CADRPPNTqADaBDyW9z+BEBJBjaaL9hfW_6Lt3dRXR48+pNZjFUw@mail.gmail.com>
 <DM2PR0301MB06409BD76B841E3AA89E74DCE24E0@DM2PR0301MB0640.namprd03.prod.outlook.com>
Message-ID: <CADRPPNQrV6tKtyR7jpAWsZcxDdrnZ31=HB0E5EPqfbX5pvF0Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 9:57 PM, Lian M.H. <Minghuan.Lian@freescale.com> wrote:
> Hi Leo,
>
> Thanks for your advice.
> "fsl,scfg-msi" is better, I use it in next version.

For the device tree compatible, "fsl,ls1043a-msi" is still a good name
while you can add "fsl,scfg-msi" as an additional compatible.  I'm
actually saying we should replace all ls1-msi stuff with scfg-msi.
And make it aligned in patch title/description, file
name/description/comment, and etc.

Regards,
Leo
