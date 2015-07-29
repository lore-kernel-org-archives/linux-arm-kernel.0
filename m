From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 Jul 2015 12:23:51 +0530
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <55B80A34.1010805@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976> <20150727030239.GG19944@linux>
 <55B80A34.1010805@codeaurora.org>
Message-ID: <20150729065351.GA2502@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-07-15, 16:03, Stephen Boyd wrote:
> There is talk about moving to 64 bits for the frequency in the clk API.
> It's not actively being developed though and I'm not sure when we'll get
> there. From a DT perspective though, I don't see why it would be bad to
> have two cells instead of one cell for the frequency here. It would
> allow up to 64 bits of frequency so that when we change the clk API we
> won't need to do anything in the OPP bindings to handle it. Just because
> we have problems in the kernel doesn't mean we should put the same
> problems into DT.

Okay, I am going to send a patch for that as well and will respin the
series again.

-- 
viresh
