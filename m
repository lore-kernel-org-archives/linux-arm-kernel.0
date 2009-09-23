From: dave123_aml@yahoo.com (David Anders)
Date: Wed, 23 Sep 2009 12:20:05 -0700 (PDT)
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <200909231046.36330.anarsoul@gmail.com>
Message-ID: <164376.11955.qm@web54401.mail.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily,

i have tried this patch on a number of S3C2440 based systems and found that this patch is not a completely effective solution. if the purpose is to get a solution even if it is an incomplete one, then i'd be ok with this patch, however, i'm not keen on accepting a patch into the main tree with the knowledge that it isn't 100% effective.

Dave Anders


--- On Wed, 9/23/09, Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
> To: "Ben Dooks" <ben-linux@fluff.org>, linux-arm-kernel at lists.infradead.org
> Date: Wednesday, September 23, 2009, 2:46 AM
> 
> 
> -----Inline Attachment Follows-----
> 
> 
> -----Inline Attachment Follows-----
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


      
