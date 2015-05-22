From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 May 2015 19:34:57 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <555D750F.80304@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <555D750F.80304@ti.com>
Message-ID: <20150522140457.GB7730@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 01:02, Nishanth Menon wrote:
> This argues that clock is an input to the cpu, this is not in-correct,
> but, it could also be argued that OPP tables are clock dependent.
> 
> For example, with multiple clock source options that a device might
> choose to select from internally(by some means.. lets not just restrict
> ourselves to just CPUs here for a moment), the tables might be
> different. We can always debate that this then is the responsibility of
> the driver handling the description for that device and we might want
> possibility of vice versa as well - same OPP table used by different
> clock source selections as well.

@Rob: Any inputs ?

-- 
viresh
