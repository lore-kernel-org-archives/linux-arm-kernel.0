From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Mar 2013 09:15:08 +0000
Subject: [PATCH 1/1] arm: remove extra semicolon in if statement
In-Reply-To: <20130301083624.GI22886@pengutronix.de>
References: <1362111952-8072-1-git-send-email-viniciustinti@gmail.com>
 <20130301083624.GI22886@pengutronix.de>
Message-ID: <20130301091508.GB27385@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 08:36:24AM +0000, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Mar 01, 2013 at 01:25:52AM -0300, Vinicius Tinti wrote:
> > Remove extra semicolon in perf_event.c if statement.
> The commit log sounds like a style fix, but your patch introduces a
> semantical change. I suspect this patch fixes a real bug, you should
> point that out here.
> 
> Best regards
> Uwe

It does fix a real bug, but Will already has a fix [1]. It's in rmk's patch
tracking system as 7664/1.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/151564.html

> > 
> > Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
> > ---
> >  arch/arm/kernel/perf_event.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index 31e0eb3..a892067 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
> >  	}
> >  
> >  	if (event->group_leader != event) {
> > -		if (validate_group(event) != 0);
> > +		if (validate_group(event) != 0)
> >  			return -EINVAL;
> >  	}
> >  
> > -- 
> > 1.7.9.5
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
