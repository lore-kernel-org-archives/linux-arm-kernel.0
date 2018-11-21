From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:54:30 +0100 (CET)
Subject: [PATCH RESEND 07/17] firmware: raspberrypi: Switch to SPDX
 identifier
In-Reply-To: <87ftvv75q8.fsf@anholt.net>
References: <1542546604-27728-1-git-send-email-stefan.wahren@i2se.com>
 <2094654733.102339.1542751718184@email.ionos.de>
 <87ftvv75q8.fsf@anholt.net>
Message-ID: <1881981920.83022.1542808470047@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 23:18 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Eric,
> >
> >> Stefan Wahren <stefan.wahren@i2se.com> hat am 18. November 2018 um 14:10 geschrieben:
> >> 
> >> 
> >> Adopt the SPDX license identifier headers to ease license compliance
> >> management.
> >> 
> >> Cc: Eric Anholt <eric@anholt.net>
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> Reviewed-by: Eric Anholt <eric@anholt.net>
> >> ---
> >>  drivers/firmware/raspberrypi.c             | 5 +----
> >>  include/soc/bcm2835/raspberrypi-firmware.h | 5 +----
> >>  2 files changed, 2 insertions(+), 8 deletions(-)
> >> 
> >> Hi, it seems that i forgot to send this patch last week.
> >
> > i accidently added your Reviewed-by which wasn't the case for this
> > particular patch. In case your fine with this patch i would apply it
> > and then from my point of view the pull request would be ready to
> > send.
> 
> I've reviewed it now, you're good to go :)

Thanks, it's now applied to bcm2835-drivers-next. So the pull request for the following branches are yours:

bcm2835-defconfig-next
bcm2835-drivers-next
bcm2835-dt-next
bcm2835-soc-next

Stefan
