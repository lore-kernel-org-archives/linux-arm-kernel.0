From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 7 Nov 2017 10:49:12 +0000
Subject: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon LPC
 driver
In-Reply-To: <20171107002120.GB9538@bhelgaas-glaptop.roam.corp.google.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-10-git-send-email-gabriele.paoloni@huawei.com>
 <20171107002120.GB9538@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC3305@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn

Many Thanks for reviewing

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 07 November 2017 00:21
> To: Gabriele Paoloni
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; rafael at kernel.org;
> arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com; mark.rutland at arm.com; brian.starkey at arm.com;
> olof at lixom.net; benh at kernel.crashing.org; linux-kernel at vger.kernel.org;
> linux-acpi at vger.kernel.org; Linuxarm; linux-pci at vger.kernel.org;
> minyard at acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon
> LPC driver
> 
> s/MANTAINERS/MAINTAINERS/

Oops thanks

> 
> On Fri, Oct 27, 2017 at 05:11:27PM +0100, Gabriele Paoloni wrote:
> > Added maintainer for drivers/bus/hisi_lpc.c
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f66488d..b49d4c0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6130,6 +6130,13 @@ F:	include/uapi/linux/if_hippi.h
> >  F:	net/802/hippi.c
> >  F:	drivers/net/hippi/
> >
> > +HISILICON LPC BUS DRIVER
> > +L:	linuxarm at huawei.com
> > +W:	http://www.hisilicon.com
> > +S:	Maintained
> > +F:	drivers/bus/hisi_lpc.c
> > +F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-
> pin-count.txt
> 
> Does this really count as a "maintainer" since it's only a mailing
> list, not a real person?  I personally prefer a specific person
> because there's no accountability with a mailing list.

Right; before the maintainer was meant to be me but as I am moving
to a different role we decided to put down a mailing list.
However after discussing internally we agreed to have a person as
maintainer and we'll specify him in the next patchset.

Cheers
Gab

> 
> > +
> >  HISILICON NETWORK SUBSYSTEM DRIVER
> >  M:	Yisen Zhuang <yisen.zhuang@huawei.com>
> >  M:	Salil Mehta <salil.mehta@huawei.com>
> > --
> > 2.7.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
