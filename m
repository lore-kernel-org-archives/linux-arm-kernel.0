From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 24 Sep 2009 22:38:06 +0300
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <200909240711.17683.fg@emlix.com>
References: <164376.11955.qm@web54401.mail.yahoo.com>
	<200909232230.03982.anarsoul@gmail.com>
	<200909240711.17683.fg@emlix.com>
Message-ID: <200909242238.11627.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ???????? 2009 08:11:17 ????? Fabian Godehardt ???????:
> On our 2440 machine i found out that adding a receive handling on the
> interrupt handler makes the driver work, and in ethernet gadget mode the
>  pings returned much faster.
> Im not realy familiar with the USB layer / protocoll so i'm not sure if
>  this breaks something else. You might have a look at this patch (it is
>  2.6.26 against 2.6.31 so maybe it will not apply successfully and you need
>  to take a hand on it).

Your patch works as well with little modification (you used && instead of &). 
And it seems to be a bit cleaner, it can't stuck in interrupt handler for a 
while as previous. Would you mind if I submit your patch as part of my 
patches? I'll add note that you're author of original patch.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090924/7518df98/attachment.sig>
