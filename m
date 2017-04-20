From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Apr 2017 15:00:56 +0530
Subject: [PATCH V4 0/7] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Message-ID: <20170420093056.GH5436@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-04-17, 11:14, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> This has been sent separately as a single patch earlier, and Olof
> suggested to split it per-platform and get it merged via platform
> specific trees. Please get these applied to your trees guys and the rest
> can go via arm-soc.

This is based over 4.11-rc7 and there are no conflicts apart from
sun8i. All the other maintainers can apply their platform specific
patches from this series only.

Thanks.

-- 
viresh
