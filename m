From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Aug 2015 16:16:25 +0530
Subject: [PATCH V1 Resend 06/10] drivers: rtc: Drop (un)likely before
 IS_ERR(_OR_NULL)
In-Reply-To: <20150812104133.GE3411@piout.net>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
 <1a92f2e1af5309ece9736f79f312e90486a98825.1439375087.git.viresh.kumar@linaro.org>
 <20150812104133.GE3411@piout.net>
Message-ID: <20150812104625.GB20238@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-08-15, 12:41, Alexandre Belloni wrote:
> Hi Viresh,
> 
> Why are you resending?

I never got a reply from Andrew Morton on V1, so resent it again. And
today Andrew asked me to take this via trivial tree.

So the resent.

I need to find a sane way to get few more people to the cover-letter.
The problem is that I am generating the cc-list with get_maintainers,
and if I combine that list for all the patches, it becomes huge. And
really can't send the cover-letter to those people then. Few lists may
block it as well, due to high number of cc'd people.

I am telling this because, the cover-letter did contain the reason for
resend.

-- 
viresh
