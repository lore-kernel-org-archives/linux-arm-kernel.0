From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 10 Feb 2017 08:43:49 +0530
Subject: [PATCH v6 2/4] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
References: <20170203172929.23940-3-d-gerlach@ti.com>
 <20170209153549.8354-1-d-gerlach@ti.com>
 <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
Message-ID: <20170210031349.GG14503@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-02-17, 23:03, Rafael J. Wysocki wrote:
> In particular, Viresh, if you ACK something, please make sure that it
> doesn't conflict with your own patches.

I hope you are talking about the patch 3/4 for which Arnd also sent a
fix.  I acked it back on 18th of January and Dave has been carrying my
Ack since then. When he posted again, I didn't went into reviewing it
again as I saw my Ack being there.

Yes, he ended up using an API which just got updated after 18th of Jan
and yes both me and Dave missed that. But I feel it is difficult to
take care of scenarios like this. Perhaps he should have made sure
that he base it of pm/linux-next and nothing would have gone wrong.

-- 
viresh
