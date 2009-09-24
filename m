From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 24 Sep 2009 01:27:15 +0100
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <164376.11955.qm@web54401.mail.yahoo.com>
References: <200909231046.36330.anarsoul@gmail.com>
	<164376.11955.qm@web54401.mail.yahoo.com>
Message-ID: <20090924002715.GH24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 12:20:05PM -0700, David Anders wrote:
> Vasily,
> 
> i have tried this patch on a number of S3C2440 based systems and found that this patch is not a completely effective solution. if the purpose is to get a solution even if it is an incomplete one, then i'd be ok with this patch, however, i'm not keen on accepting a patch into the main tree with the knowledge that it isn't 100% effective.
> 
> Dave Anders

I think that if this is afix that makes the code mostly work then
there really should be some form of note in the code that says that this
fix is a mostly effective form.
 
> 
> --- On Wed, 9/23/09, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> 
> > From: Vasily Khoruzhick <anarsoul@gmail.com>
> > Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
> > To: "Ben Dooks" <ben-linux@fluff.org>, linux-arm-kernel at lists.infradead.org
> > Date: Wednesday, September 23, 2009, 2:46 AM
> > 
> > 
> > -----Inline Attachment Follows-----
> > 
> > 
> > -----Inline Attachment Follows-----
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
>       

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
