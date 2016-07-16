From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 16 Jul 2016 11:01:41 +0200
Subject: [RESEND PATCH] arm: colibri_pxa270_defconfig: disable IDE
 subsystem
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <1467991490-24895-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <871t2u2byi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> This patch disables deprecated IDE subsystem in colibri_pxa270_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
Hi Bartlomiej,

It seems I have missed that serie a year ago ...
I can't remember why I have not taken it in at that time, I'm still going
through my mails ...

If I don't find anything relevant, and given that I'm not expecting anyone to
object, I'm going to queue that in pxa/for-next within the next week.

Cheers.

-- 
Robert
