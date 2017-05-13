From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 14 May 2017 01:23:52 +0900
Subject: [PATCH V5 6/7] ARM: uniphier: Use - instead of @ for DT OPP
 entries
In-Reply-To: <1faba32eeaa493cc5463488af32eaea0dc2f7a94.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <1faba32eeaa493cc5463488af32eaea0dc2f7a94.1492685450.git.viresh.kumar@linaro.org>
Message-ID: <CAK7LNASgFd1V=gRpEqOsQkRpqVZu25N10mCSjRR=Vbmwbxp6yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-20 19:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> Compiling the DT file with W=1, DTC warns like follows:
>
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
>
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to linux-uniphier.  Thanks!



-- 
Best Regards
Masahiro Yamada
