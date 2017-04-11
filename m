From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 11 Apr 2017 10:13:58 +0900
Subject: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Message-ID: <CAK7LNATAW4jHbKZU6xWD_nU=ccFo73rBSX_UDpQEMo9OC_u=cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,


2017-04-10 18:21 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
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
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com> (uniphier)


Thank you!




-- 
Best Regards
Masahiro Yamada
