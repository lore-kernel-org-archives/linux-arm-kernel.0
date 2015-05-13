From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 May 2015 10:11:29 +0530
Subject: [PATCH V4 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <555225A0.8050707@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
 <555225A0.8050707@ti.com>
Message-ID: <20150513044129.GC28858@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-05-15, 11:09, Nishanth Menon wrote:
> On 04/30/2015 07:08 AM, Viresh Kumar wrote:
> > (sort of an eeprom) and knowing characteristics of the SoC.
> 
> they are more like prom than eeprom in many instances.

Will replace.

> With some SoCs like AM335x - thanks to some brain dead incompatible
> hardware design choices, this might end up as a big list or various
> OPP tables. but overall, I must prefer this approach as well.
> 
> Thanks for proposing this. will be great to see examples documented in
> bindings doc as well.

Right.

-- 
viresh
