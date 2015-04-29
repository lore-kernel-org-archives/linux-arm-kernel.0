From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 Apr 2015 11:36:46 +0530
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <CALx668W_rj8_UBory5fVa4_i3vLCjgApYCwHoSthXNmx79yH1g@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150423125620.GB29702@leverpostej>
 <CALx668W_rj8_UBory5fVa4_i3vLCjgApYCwHoSthXNmx79yH1g@mail.gmail.com>
Message-ID: <CAKohpokhbh3QoDsG=2q3YGLnhhoumOkipj_zdd-JPfVSA0X5cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2015 at 12:20, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> So even we have a new OPP binding to describe the OPP, we have to
> leave these table as they are for backward compatibility?

Yes.

I could find the below excerpts from [1]:

"The compatibility rules say that new kernels must work with older
device trees. If changes are required, they should be put into new
properties; the old ones can then be deprecated but not removed. New
properties should be optional, so that device trees lacking those
properties continue to work. The device tree developers will provide a
set of guidelines for the creation of future-proof bindings."

--
viresh

[1] http://lwn.net/Articles/572114/
