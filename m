From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 10:44:25 +0100
Subject: [GIT PULL] soc: samsung: Drivers for v4.11
In-Reply-To: <4be96fae-6790-d281-61dc-f7e7cde9efb7@samsung.com>
References: <20170120181343.12570-1-krzk@kernel.org>
 <CGME20170126091313epcas3p4034ef54af813082ceb26f5213bb97a1c@epcas3p4.samsung.com>
 <CACRpkdZebsd5MfARWL2WbKkAuXfjEe6p_k5tYwPFF6kSsCXDdQ@mail.gmail.com>
 <4be96fae-6790-d281-61dc-f7e7cde9efb7@samsung.com>
Message-ID: <CACRpkdbKfojW-adLDL5Y7UQNps9H=5NpwWnYOzC5xBo9Bq1RJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:20 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Linus,
>
> On 2017-01-26 10:13, Linus Walleij wrote:
>>
>> On Fri, Jan 20, 2017 at 7:13 PM, Krzysztof Kozlowski <krzk@kernel.org>
>> wrote:
>>
>>> Few changes in Exynos PMU driver including one that is needed by pinctrl
>>> driver for runtime PM. We want to move forward with the RPM for our
>>> drivers
>>> while keeping still DT ABI.
>>>
>>> This tag is also for Linus Walleij to pull - base for pinctrl changes.
>>
>> Do I need it? I.e. will my branch not compile without this, or is this
>> just a runtime problem?
>
>
> "[PATCH v3 11/13] pinctrl: samsung: Move retention control from mach-exynos
> to the
> pinctrl driver" has compile time dependency on the changes included in that
> tag.

Is that because of the custom syscon regmap lookup function?

I just complained about that in a separate mail ;)

Yours,
Linus Walleij
