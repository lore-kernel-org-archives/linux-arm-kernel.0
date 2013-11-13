From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Nov 2013 13:33:52 +0530
Subject: [PATCH 5/7] clocksource/cadence_ttc: Overhaul clocksource
 frequency adjustment
In-Reply-To: <52827B11.5040308@linaro.org>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383945677-29674-6-git-send-email-soren.brinkmann@xilinx.com>
 <52827B11.5040308@linaro.org>
Message-ID: <CAKohpo=KaM97jJ2MnZxSeBz=Mf9cSmzk_EFQTL=EVPPvSH=Wag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2013 00:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Hmm, it could be interesting if Viresh can give its opinion on this patch
> [cc'ed].

I am not sure if I understood the problem completely, but if this is about
not allowing frequency transitions from cpufreq when we have started to
suspend our system, then you must have a look at this thread:

https://lkml.org/lkml/2013/10/24/369
