From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 17:06:41 +0530
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <3141301.RS9TLygaba@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1595601.YD6UTxy5Qg@amdc1976> <20150727103521.GA4103@linux>
 <3141301.RS9TLygaba@amdc1976>
Message-ID: <20150727113641.GB10181@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-15, 13:14, Bartlomiej Zolnierkiewicz wrote:
> Sorry but you don't seem to understand the issue.

:)

No, I did. I understand that if someone uses opp bindings today with
some entries as turbo OPPs, cpufreq will use them as normal
frequencies. And that may harm the board.

BUT, opp-v2 code isn't ready to be used yet. And platforms should see
what all is implemented before trying to use them.

All I was saying is, this isn't a FIX as we haven't introduced the
feature yet. Otherwise I had no issues with the patch.

-- 
viresh
