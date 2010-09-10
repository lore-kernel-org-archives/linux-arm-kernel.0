From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Sep 2010 20:38:39 +0900
Subject: [rtc-linux] RE: [PATCH 5/5] rtc: rtc-s3c: Fix debug message	format
	on RTC
In-Reply-To: <AANLkTi=Jb04ySn1WaGktY-hJQQoGvRpr6kz9DcSHrBZA@mail.gmail.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-6-git-send-email-kgene.kim@samsung.com>
	<4C86CAC1.2050205@fluff.org>
	<000601cb4fbb$f9fbab90$edf302b0$%kim@samsung.com>
	<AANLkTi=Jb04ySn1WaGktY-hJQQoGvRpr6kz9DcSHrBZA@mail.gmail.com>
Message-ID: <000f01cb50dc$ba4a74a0$2edf5de0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:
> 
> 2010/9/9 Kukjin Kim <kgene.kim@samsung.com>:
> > Ben Dooks wrote:
> >>
> >> On 07/09/10 06:29, Kukjin Kim wrote:
> >> > This patch fixes debug message format on rtc-s3c.
> >> >
> >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> > Cc: Ben Dooks <ben-linux@fluff.org>
> >> > ---
> >> >  drivers/rtc/rtc-s3c.c |   18 +++++++++---------
> >> >  1 files changed, 9 insertions(+), 9 deletions(-)
> >> >
> >>
> >> how long has this lot been broken for?
> >>
> > Haha...we don't know :-)
> >
> >> Acked-by: Ben Dooks <ben-linux@fluff.org>
> >
> > Thanks for your ack...so...
> >
> > Hi Alessandro Zummo,
> > Is it possible to send this to upstream through your tree?
> > Or which tree is better to care this.
> 
> 
> Please get help from Andrew.
> 
Ok ;-)

Hello Andrew,

Could you please handle following items which have been got Ben's ack?

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025387.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025388.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025391.html

And it's available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next-rtc-s3c

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
