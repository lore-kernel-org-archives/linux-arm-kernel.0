From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Apr 2017 11:07:51 +0900
Subject: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <2765521.jPoRkFTblf@aspire.rjw.lan>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
 <2765521.jPoRkFTblf@aspire.rjw.lan>
Message-ID: <CAK7LNAQ7Uf1Jkj64-Ykdk5TSeWvkq7=BaqUMJo6KqrN7BhYvsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-15 7:47 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Monday, April 10, 2017 02:51:35 PM Viresh Kumar wrote:
>> Compiling the DT file with W=1, DTC warns like follows:
>>
>> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
>> unit name, but no reg property
>>
>> Fix this by replacing '@' with '-' as the OPP nodes will never have a
>> "reg" property.
>>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> OK, so any ACKs from the DT side?  Rob?
>
> Thanks,
> Rafael



I see Rob's Acked-by.

https://lkml.org/lkml/2017/4/13/648


-- 
Best Regards
Masahiro Yamada
