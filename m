From: fg@emlix.com (Fabian Godehardt)
Date: Fri, 25 Sep 2009 06:32:37 +0200
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <200909242238.11627.anarsoul@gmail.com>
References: <164376.11955.qm@web54401.mail.yahoo.com>
	<200909240711.17683.fg@emlix.com>
	<200909242238.11627.anarsoul@gmail.com>
Message-ID: <200909250632.37104.fg@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

Am Donnerstag 24 September 2009 21:38:06 schrieb Vasily Khoruzhick:
> Your patch works as well with little modification (you used && instead of
>  &). And it seems to be a bit cleaner, it can't stuck in interrupt handler
>  for a while as previous. Would you mind if I submit your patch as part of
>  my patches? I'll add note that you're author of original patch.

I have no problem with it. Please submit it with your patches. Thanks.


Regards,
Fabian Godehardt

-- 
Dipl.-Ing. (FH) Fabian Godehardt, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G?ttingen, Germany
Sitz der Gesellschaft: G?ttingen, Amtsgericht G?ttingen HR B 3160
Gesch?ftsf?hrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
