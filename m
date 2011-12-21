From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 13:06:14 +0900
Subject: [PATCH 1/8] s3c-hsudc: move platform_data struct to global header
In-Reply-To: <201112201236.37581.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191939.16542.heiko@sntech.de>
 <20111220112458.GG31842@legolas.emea.dhcp.ti.com>
 <201112201236.37581.heiko@sntech.de>
Message-ID: <061801ccbf95$e1df4580$a59dd080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Dienstag, 20. Dezember 2011, 12:25:00 schrieb Felipe Balbi:
> > Hi,
> >
> > On Mon, Dec 19, 2011 at 07:39:15PM +0100, Heiko St?bner wrote:
> > > Gadget drivers should be compilable on all architectures.
> > > This patch removes one dependency on architecture-specific code.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >
> > >  arch/arm/mach-s3c2416/mach-smdk2416.c    |    1 +
> > >  arch/arm/plat-samsung/devs.c             |    1 +
> > >  arch/arm/plat-samsung/include/plat/udc.h |   15 +------------
> >
> > I would like to have ack from Ben and/or Kukjin before applying this
> > one. Ben are you ok with this patch ?
> I think Kukjin does more acking if this stuff currently, so hopefully he will
> see this mail.
> 

Hi Felipe,

Looks ok to me, you can go ahead with my ack.
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
