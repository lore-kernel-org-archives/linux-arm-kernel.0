From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 5 Jun 2015 08:11:24 +0530
Subject: [PATCH V7 1/3] OPP: Add new bindings to address shortcomings of
 existing bindings
In-Reply-To: <20150604183752.GI490@codeaurora.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
 <20150604183752.GI490@codeaurora.org>
Message-ID: <20150605024124.GA9448@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-06-15, 11:37, Stephen Boyd wrote:
> Ok. I'm still interested to see if this binding will have to
> change to support how multiple regulators will be matched up with
> the device using the OPP.

I can understand your concern here, but getting everything working
on the first attempt would be difficult to write/review.. There will at
least be 5-7 patches just for getting the very basic v2 bindings
coded. And so we can get all that coded slowly and steadily.

> But for now,
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks. Finally :)

-- 
viresh
