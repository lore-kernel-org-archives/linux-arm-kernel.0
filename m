From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 6 Nov 2018 19:13:18 +0100 (CET)
Subject: [PATCH] firmware: raspberrypi: Define timeout for transactions
In-Reply-To: <87k1lyghp7.fsf@anholt.net>
References: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
 <87k1lyghp7.fsf@anholt.net>
Message-ID: <619586887.222691.1541527998449@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Eric Anholt <eric@anholt.net> hat am 31. Oktober 2018 um 18:16 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > We should never assume to get a reply from the firmware otherwise
> > the call could block forever and the user don't get informed. So
> > define a timeout of 1 sec and print a stacktrace once in the unlikely
> > case the timeout expired.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-soc-next
