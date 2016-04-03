From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 3 Apr 2016 17:57:00 +0530
Subject: dtc warnings
In-Reply-To: <20160403080854.GA12133@kozik-lap>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com> <20160403065909.GF2987@vireshk-i7>
 <20160403080854.GA12133@kozik-lap>
Message-ID: <CAKohpomijKf3m07Lc3+fWawxAPwe83F8k9akz1LOTokpZNL2ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2016 at 13:38, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> Warnings coming from recent linux-next:
>
>   DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1800000000 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1700000000 has a unit name, but no reg property

@Rob: What should we be doing about these warnings?
OPP-entries don't have a reg property obviously and we
discussed earlier if naming them based on freq is fine or
not.

--
viresh
