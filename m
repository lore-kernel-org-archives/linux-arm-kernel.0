From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 26 May 2015 10:44:09 +0530
Subject: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <555D6CC8.9050201@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
 <555D6CC8.9050201@ti.com>
Message-ID: <20150526051409.GI23464@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 00:27, Nishanth Menon wrote:
> I would suggest adding a link to how future vendor specific extension
> docs might look like - maybe this is probably not the time to discuss
> this.. but anyways.. we could make some statement to the effect of "SoC
> vendor specfic extensions are documented as
> Documentation/devicetree/bindings/power/<vendor>,opp.txt and should
> clearly indicate that the extensions are permitted only under the
> operating-points-v2 compatible description."

Will this work ?:

If required, this can be extended for SoC vendor specfic bindings. Such bindings
should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
and should have a compatible description like: "operating-points-v2-<vendor>".

-- 
viresh
