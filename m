From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Mar 2015 14:52:51 +0530
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150310235912.14952.99786@quantum>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150310235912.14952.99786@quantum>
Message-ID: <CAKohpon-zbFdymPvzcAf0OK1wuCq_ShbdFKFXySb-ToMpZCMEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 05:29, Mike Turquette <mturquette@linaro.org> wrote:
> I assume you are saying that you want to update loops-per-jiffie while
> at an intermediate frequency. Why? This operation should not take very
> long.
>
> Imagine a (hypothetical?) processor that changes frequency in many small
> steps until it converges to the target rate. Would you want to update
> lpj for every step?

That's why I have asked Russell specifically about this but haven't got a reply
yet. But it looks wrong to me as well now.. Probably we don't need to care
about it at all..
