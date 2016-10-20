From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Oct 2016 20:57:45 +0200 (CEST)
Subject: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <87twczg27x.fsf@eliezer.anholt.net>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
 <87twczg27x.fsf@eliezer.anholt.net>
Message-ID: <597494624.18802.29d80fd4-97bf-46c7-b133-c253e7ed6a47.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 28. September 2016 um 23:10 geschrieben:
> 
> 
> kernel at martin.sperl.org writes:
> 
> > From: Martin Sperl <kernel@martin.sperl.org>
> >
> > Add basic thermal driver for bcm2835 SOC.
> >
> > This driver currently relies on the firmware setting up the
> > tsense HW block and does not set it up itself.
> >
> > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> > Acked-by: Eric Anholt <eric@anholt.net>
> > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> What's the status of merging this one?  I'd like to merge the other
> patches.

gently ping ...
