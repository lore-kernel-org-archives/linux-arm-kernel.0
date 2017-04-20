From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Apr 2017 14:59:42 +0530
Subject: [PATCH V4 5/7] ARM: sun8i: Use - instead of @ for DT OPP entries
In-Reply-To: <20170420080202.olu2mhel6xtmnnjt@lukather>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
 <d13e447e9cc080d81c4f2db3bd5433506d3ef739.1492666725.git.viresh.kumar@linaro.org>
 <20170420080202.olu2mhel6xtmnnjt@lukather>
Message-ID: <20170420092942.GG5436@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-04-17, 10:02, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Apr 20, 2017 at 11:14:16AM +0530, Viresh Kumar wrote:
> > Compiling the DT file with W=1, DTC warns like follows:
> > 
> > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> > unit name, but no reg property
> > 
> > Fix this by replacing '@' with '-' as the OPP nodes will never have a
> > "reg" property.
> > 
> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> This patch doesn't apply, please make sure to base them on linux-next

I can do that tomorrow once linux-next includes the new PM tree as the
old PM tree had my patch from V3.

-- 
viresh
