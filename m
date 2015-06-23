From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 13:25:59 +0530
Subject: [PATCH 5/8] ARM: STi: STiH407: Move PWM nodes STiH407 =>
 STiH407-family
In-Reply-To: <20150623070822.GB3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-6-git-send-email-lee.jones@linaro.org>
 <20150623021708.GB16776@linux> <20150623070822.GB3245@x1>
Message-ID: <20150623075559.GG16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-06-15, 08:08, Lee Jones wrote:
> Because the CPUFreq regulator is controlled with PWM and CPUFreq will
> fail on STiH410 (my main development platform) without it.

I see, probably this should find a place in the cover-letter :)

> It's safe for you to ignore it though.

Thanks :)

-- 
viresh
