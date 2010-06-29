From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 29 Jun 2010 20:32:13 +0900
Subject: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
	driver
In-Reply-To: <201006250618.37076.marek.vasut@gmail.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
	<4C22704B.50103@pobox.com>
	<001f01cb1417$dce8f8d0$96baea70$%kim@samsung.com>
	<201006250618.37076.marek.vasut@gmail.com>
Message-ID: <00e701cb177e$bab1e550$3015aff0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut wrote:
> 
Hello Marek,

> Dne P? 25. ?ervna 2010 05:38:19 Kukjin Kim napsal(a):
> > Jeff Garzik wrote:
> > > On 06/14/2010 03:07 AM, Kukjin Kim wrote:
> > > > From: Abhilash Kesavan<a.kesavan@samsung.com>
> > > >
> > > > Adds support for the Samsung PATA controller. This driver is based on
> >
> > the
> >
> > > > Libata subsystem and references the earlier patches sent for IDE
> >
> > subsystem.
> >
> > > > Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> > > > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> > >
> > > Acked-by: Jeff Garzik <jgarzik@redhat.com>
> > >
> > > Send it through the appropriate subsystem tree for this platform...
> >
> > Hi,
> >
> > You mean in my case, appropriate subsystem tree is ARM tree.
> > But I think, as Ben commented, it's better drivers go to upstream via the
> > driver's tree.
> > And of course, I read your comments about this like below...
> > 'platform drivers do not build and/or work without additional platform
> > glue...'
> >
> > Hmm.
> > I'm not sure which way is better...
> 
> I pushed pata_pxa through Eric as well ... go for the linux-arm tree.

Thanks for your help ;-)

But if possible, rmk patch tracking system is better to me.
As Russell's comments, I will send to rmk with Ben's ack.

Thanks.

> Cheers
> >
> > Russell,
> >
> > How do you think?
> > May I send this to your patch tracking system?
> > Or...how should I handle this?
> >

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
