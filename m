From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 08:16:44 +0900
Subject: [rtc-linux] RE: [PATCH 5/5] rtc: rtc-s3c: Fix debug message format
	on RTC
In-Reply-To: <20100910162354.9b96f1df.akpm@linux-foundation.org>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-6-git-send-email-kgene.kim@samsung.com>
	<4C86CAC1.2050205@fluff.org>
	<000601cb4fbb$f9fbab90$edf302b0$%kim@samsung.com>
	<AANLkTi=Jb04ySn1WaGktY-hJQQoGvRpr6kz9DcSHrBZA@mail.gmail.com>
	<000f01cb50dc$ba4a74a0$2edf5de0$%kim@samsung.com>
	<20100910162354.9b96f1df.akpm@linux-foundation.org>
Message-ID: <00c101cb6675$bb8e67f0$32ab37d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton wrote:
> 
> On Fri, 10 Sep 2010 20:38:39 +0900
> Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> > Wan ZongShun wrote:
> > >
> > > 2010/9/9 Kukjin Kim <kgene.kim@samsung.com>:
> > > > Ben Dooks wrote:
> > > >>
> > > >> On 07/09/10 06:29, Kukjin Kim wrote:
> > > >> > This patch fixes debug message format on rtc-s3c.
> > > >> >
> > > >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > > >> > Cc: Ben Dooks <ben-linux@fluff.org>
> > > >> > ---
> > > >> >  drivers/rtc/rtc-s3c.c |   18 +++++++++---------
> > > >> >  1 files changed, 9 insertions(+), 9 deletions(-)
> > > >> >
> > > >>
> > > >> how long has this lot been broken for?
> > > >>
> > > > Haha...we don't know :-)
> > > >
> > > >> Acked-by: Ben Dooks <ben-linux@fluff.org>
> > > >
> > > > Thanks for your ack...so...
> > > >
> > > > Hi Alessandro Zummo,
> > > > Is it possible to send this to upstream through your tree?
> > > > Or which tree is better to care this.
> > >
> > >
> > > Please get help from Andrew.
> > >
> > Ok ;-)
> >
> > Hello Andrew,
> >
> > Could you please handle following items which have been got Ben's ack?
> >
> >
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025387.
html
> >
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025388.
html
> >
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025391.
html
> >
> > And it's available in the git repository at:
> >    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-rtc-
> s3c
> >
> > If any problems, please let me know.
> >
> 
> I'd prefer to handle the whole series rather than cherrypick a subset
> of it.
> 
> Patch 1/5 has a question from Ben which hasn't been responded to yet.
> 
> Patch 4/5 is due to be updated.
> 
> So please let's fix those things up, resend the entire series and cc me
> on the emails?

Hi Andrew,

Sorry for late response.

Updated patch 1/5 has been tested on S3C24XX and its working fine.
Its remained issue is that Ben was wondering its working on S3C24XX.

And about the patch 4/5, I did address comments from Ben Dooks and Wan
ZongShun.

So could you please handle this series?
If any problems, please kindly let me know.

They are since commit cb655d0f3d57c23db51b981648e452988c0223f9:
  Linux 2.6.36-rc7 (2010-10-06 13:39:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-rtc-s3c

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
