From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 17:03:40 +0530
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <15810554.2OjPyuYJBt@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
 <20150727083754.GD31611@linux> <15810554.2OjPyuYJBt@amdc1976>
Message-ID: <20150727113340.GA10181@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-15, 13:01, Bartlomiej Zolnierkiewicz wrote:

First of all, please don't be angry :).. We can discuss and get things
sorted out ...

> This change was in the original patch posted in April:
> https://lkml.org/lkml/2015/4/10/646

Yeah, and I already apologized for missing the request :)

> your review from a month ago didn't contain this request:
> https://lkml.org/lkml/2015/6/22/667

Your patch inserted almost 116 lines and most of the stuff was around
adding new bindings to get things working with cpufreq-dt driver.

And so I replied to the most important stuff, i.e. don't add new
bindings, we will sort it out with opp-v2.

And frankly that wasn't the time where we could have discussed how
exactly we are going to use it. Ofcourse we should get it via DT,
platform data is just not required.

So, me not NAK ing this approach was fine as it wasn't about keeping
this data in the platform data part.

> and now (after nearly 4 months) you are telling me that

I will say a month, as we discarded most of that patch recently :)

> I should change this because you are planning to do some
> more changes in the future.

Its not about me doing some changes. But the whole point of doing the
opp-v2 thing was to get rid of such platform data things..

Just that your work is competing with opp-v2 code :)

> Could we please keep it as it is for now and change it
> later (after independent_clocks configuration will get
> ported to use device tree)?

I thought we can get your work to a better shape, with all credit to
you. But if you have some dependency on this for 4.3, then I don't
mind killing this structure after you have polluted it a bit more :)

-- 
viresh
