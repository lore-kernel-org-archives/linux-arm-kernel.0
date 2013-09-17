From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Sep 2013 16:29:24 -0700
Subject: [PATCH] ARM: OMAP: fix return value check in
 omap_device_build_from_dt()
In-Reply-To: <87r4dg6lj2.fsf@linaro.org>
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
 <20130821071901.GR7656@atomide.com> <87r4dg6lj2.fsf@linaro.org>
Message-ID: <20130917232924.GN9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130826 17:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Kevin,
> >
> > * Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
> >> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >> 
> >> In case of error, the function omap_device_alloc() returns ERR_PTR()
> >> and never returns NULL. The NULL test in the return value check
> >> should be replaced with IS_ERR().
> >
> > Looks like this is still pending, care to take this?
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Looks fine to me, since I don't have anything else in the queue, feel
> free to queue up for fixes-non-critical.

Applying into omap-for-v3.12/fixes thanks.

Tony
