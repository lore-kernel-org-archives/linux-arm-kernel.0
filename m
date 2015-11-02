From: alison.wang@freescale.com (Huan Wang)
Date: Mon, 2 Nov 2015 05:54:09 +0000
Subject: [PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <CAOMZO5ACSg0VmYV=5Q=gWtP5OZdUXkXa_SDmTC-t8gbzmLVdEg@mail.gmail.com>
References: <1445956507-34026-1-git-send-email-b18965@freescale.com>
 <CAOMZO5ACSg0VmYV=5Q=gWtP5OZdUXkXa_SDmTC-t8gbzmLVdEg@mail.gmail.com>
Message-ID: <BN3PR0301MB0867D05039A429CA6CD62E54FE2C0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn,

	Could you help to review this patch? If it's ok, could you help to merge it?

	Thanks.

Best Regards,
Alison Wang

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, October 29, 2015 9:11 PM
> To: Wang Huan-B18965
> Cc: Shawn Guo; Russell King; Arnd Bergmann; linux-arm-
> kernel at lists.infradead.org; linux-kernel; Jin Zhengxiong-R64188; Wang
> Huan-B18965
> Subject: Re: [PATCH] ARM: add v7 LPAE multi-platform defconfig
> 
> On Tue, Oct 27, 2015 at 12:35 PM, Alison Wang <b18965@freescale.com>
> wrote:
> > v7 LPAE multi-platform defconfig is based on v7 multi-platform
> > defconfig and adds LPAE support.
> >
> > This defconfig is verified on LS1021A which enables GIANFAR, I2C,
> > WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 
> Much better now without CONFIG_VMSPLIT_2G=y :-)
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
