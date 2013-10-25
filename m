From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Oct 2013 15:53:17 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <201310250006.28668.arnd@arndb.de>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
 <201310250006.28668.arnd@arndb.de>
Message-ID: <CACRpkdYANuqDo2V2WfvdN6KNnAb9adU-jdh96ra7RRo2Lvg9xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 12:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 24 October 2013, Linus Walleij wrote:
>
>> I would lean toward just applying it and see if the OpenWRT
>> people will notice and/or complain.
>>
>> What does the ARM SoC people say?
>
> I'd prefer applying it as-is.

OK Olof/Kevin: can either of you strip "RFT" from $SUBJECT
and apply this patch to the ARM SoC tree?

Yours,
Linus Walleij
