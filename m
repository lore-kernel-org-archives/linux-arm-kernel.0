From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 4 Jan 2011 12:19:21 -0800
Subject: [PATCH v3 0/4] Introduce hardware spinlock framework
In-Reply-To: <AANLkTikLuu+njQA_PRmS_q8zs_xpB2gsqh3oZQJkB_Cm@mail.gmail.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
	<AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
	<20101214170656.GA3832@kroah.com>
	<AANLkTi=q=QMQ_Abxb8eUWT_qGG8K=pc892ZB-mqgt_mh@mail.gmail.com>
	<20101216210837.GA22895@kroah.com>
	<AANLkTi=s_Urcin4SAp1mXrKmoyzR2=6YuS3aU+OYYgqK@mail.gmail.com>
	<20101218005311.GE5941@atomide.com>
	<AANLkTikLuu+njQA_PRmS_q8zs_xpB2gsqh3oZQJkB_Cm@mail.gmail.com>
Message-ID: <20110104121921.3550dcfa.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011 14:23:20 +0200
Ohad Ben-Cohen <ohad@wizery.com> wrote:

> Hi Andrew,
> 
> On Sat, Dec 18, 2010 at 2:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Ohad Ben-Cohen <ohad@wizery.com> [101216 13:34]:
> >> Tony, Andrew, can you please have a look ?
> >>
> >> Any comment or suggestion is appreciated.
> >
> > Looks sane to me from omap point of view and it seems the locks
> > are now all timeout based:
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Can you please have a look at this patch set (see link no. [1] below) ?

I looked - it looks reasonable.  This is exactly the wrong time to be
looking at large new patchsets - please refresh, retest and resend
after -rc1 is released?
