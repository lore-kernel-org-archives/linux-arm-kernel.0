From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Aug 2017 22:41:56 +0200
Subject: [PATCH 09/11] watchdog: ftwdt010/aspeed: Merge Aspeed into
 FTWDT010
In-Reply-To: <20170814150434.GH14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-10-linus.walleij@linaro.org>
 <20170814150434.GH14491@roeck-us.net>
Message-ID: <CACRpkdYVHXqX-f6hvP4Qhi4+vawyiqdzqRamH_JbbHec2cEf9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 5:04 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sat, Aug 12, 2017 at 08:43:16PM +0200, Linus Walleij wrote:
>> These two drivers is for the almost the same hardware,
>> the only differences are:
>> - The Aspeed IP block has been hacked to use a different
>>   magic value.
>> - The Aspeed has hard-wired 1MHz to the EXTCLK and
>>   apparently even disabled the use of PCLK for clocking
>>   the block on AST2500.
>>
> Confused. I thought the ast2500 is an EC. Am I missing something ?

Sorry I'm confused too now... What is EC?
Can you spell out that acronym, I never heard
it, or forgot it.

Yours,
Linus Walleij
