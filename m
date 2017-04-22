From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Apr 2017 21:29:39 +0200
Subject: [PATCH V5 4/7] ARM: pxa: Use - instead of @ for DT OPP entries
In-Reply-To: <874lxhkauf.fsf@belgarion.home> (Robert Jarzmik's message of
 "Fri, 21 Apr 2017 18:02:32 +0200")
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <cover.1492685450.git.viresh.kumar@linaro.org>
 <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
 <87a87a7s66.fsf@belgarion.home> <20170421053041.GB26900@vireshk-i7>
 <874lxhkauf.fsf@belgarion.home>
Message-ID: <87wpaci6l8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Viresh Kumar <viresh.kumar@linaro.org> writes:
>
>> On 20-04-17, 22:14, Robert Jarzmik wrote:
>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>> 
>>> > Compiling the DT file with W=1, DTC warns like follows:
>>> >
>>> > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
>>> > unit name, but no reg property
>>> >
>>> > Fix this by replacing '@' with '-' as the OPP nodes will never have a
>>> > "reg" property.
>>> >
>>> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> > Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> > Acked-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Thanks. But I need you to pick it up for your pull request for arm-soc.
Applied to pxa/dt tree, thanks.

Cheers.

-- 
Robert
