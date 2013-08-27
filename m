From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 26 Aug 2013 17:10:41 -0700
Subject: [PATCH] ARM: OMAP: fix return value check in
 omap_device_build_from_dt()
In-Reply-To: <20130821071901.GR7656@atomide.com> (Tony Lindgren's message of
 "Wed, 21 Aug 2013 00:19:01 -0700")
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
 <20130821071901.GR7656@atomide.com>
Message-ID: <87r4dg6lj2.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> Kevin,
>
> * Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> In case of error, the function omap_device_alloc() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check
>> should be replaced with IS_ERR().
>
> Looks like this is still pending, care to take this?

Acked-by: Kevin Hilman <khilman@linaro.org>

Looks fine to me, since I don't have anything else in the queue, feel
free to queue up for fixes-non-critical.

Kevin
