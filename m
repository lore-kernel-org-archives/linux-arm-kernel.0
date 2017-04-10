From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 10 Apr 2017 11:52:58 +0530
Subject: [PATCH] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Message-ID: <20170410062258.GA24555@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-04-17, 10:46, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

+ Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

-- 
viresh
