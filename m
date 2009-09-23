From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 23 Sep 2009 22:29:18 +0300
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <164376.11955.qm@web54401.mail.yahoo.com>
References: <164376.11955.qm@web54401.mail.yahoo.com>
Message-ID: <200909232230.03982.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 23 ???????? 2009 22:20:05 ????? David Anders ???????:
> Vasily,
> 
> i have tried this patch on a number of S3C2440 based systems and found that
>  this patch is not a completely effective solution. if the purpose is to
>  get a solution even if it is an incomplete one, then i'd be ok with this
>  patch, however, i'm not keen on accepting a patch into the main tree with
>  the knowledge that it isn't 100% effective.

Hi, Dave

s3c2410_udc driver is almost useless (at least it's very inconvenient) on 
s3c244x machines without this patch. I think it's much better to have 
incomplete solution than broken driver.

Btw, I can resend patchset without this patch if maintainer of this driver 
thinks that accepting this patch is bad idea.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090923/1db519e5/attachment.sig>
