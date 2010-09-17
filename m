From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 17 Sep 2010 20:40:22 +0530
Subject: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
In-Reply-To: <AANLkTi=z+FE14Uacfhuuk_U_g-9taMsN9tL4VW-j5qt0@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=z+FE14Uacfhuuk_U_g-9taMsN9tL4VW-j5qt0@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307E7B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: cooloney at gmail.com [mailto:cooloney at gmail.com] On Behalf Of Bryan Wu
> Sent: Friday, September 17, 2010 8:36 PM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> support
> 
> Santosh,
> 
> Unfortunately, the kernel still cannot find MMC device and mount the
> root file system on my Panda ES2.0 8 layers board.
> Did we miss some patches? The Ubuntu 2.6.35 kernel boots fine.
> 
Use the patch posted by Madhu for MMC apart from this series
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34855.html

I didn't find any issues with my es2.0 Panda board.
Kevin also tested his Panda where MMC worked well.

Not sure what is the problem with your board,

Regards,
Santosh
