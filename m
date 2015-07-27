From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 13:01:43 +0200
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <20150727083754.GD31611@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
 <20150727083754.GD31611@linux>
Message-ID: <15810554.2OjPyuYJBt@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 02:07:54 PM Viresh Kumar wrote:
> On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> > diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
> > index 0414009..483ca1b 100644
> > --- a/include/linux/cpufreq-dt.h
> > +++ b/include/linux/cpufreq-dt.h
> > @@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
> >  	 * clock.
> >  	 */
> >  	bool independent_clocks;
> > +	bool boost_supported;
> >  };
> 
> I am planning to kill this structure soon, don't add anything to it.
> We should be doing this based on DT.

This change was in the original patch posted in April:
https://lkml.org/lkml/2015/4/10/646

your review from a month ago didn't contain this request:
https://lkml.org/lkml/2015/6/22/667

and now (after nearly 4 months) you are telling me that
I should change this because you are planning to do some
more changes in the future.

Could we please keep it as it is for now and change it
later (after independent_clocks configuration will get
ported to use device tree)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
