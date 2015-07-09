From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 9 Jul 2015 10:48:46 +0530
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <2910042.ys2zsBBKt2@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
Message-ID: <20150709051845.GM1805@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Isn't using u32 for storing frequency (in Hz) too small by today's
> standards?
> 
> [ Please note that the old v1 binding uses kHz not Hz. ]

Hmm, probably yes we need it to be u64. Thanks for pointing out.

-- 
viresh
