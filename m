From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Nov 2017 11:03:39 +0100
Subject: [PATCH 0/4] [v7] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <b8bbba8d-f91f-8e8f-8e79-2e772b48d9b9@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <c219c289-9cad-f96c-f766-ec28af8f078d@codeaurora.org>
 <CACRpkdbwe9+TovFYoD-W_9kabe+jsVbN6juJQBUzicq=1XDphg@mail.gmail.com>
 <b8bbba8d-f91f-8e8f-8e79-2e772b48d9b9@codeaurora.org>
Message-ID: <CACRpkdYT1NDzuEuDU47jC-iXTE8JWxqGnKhJYKp0oGiL1wX7ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 10:53 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 11/13/2017 03:49 PM, Linus Walleij wrote:
>>
>>
>>  From what I have understood Qualcomm has one finger constantly
>> on the fast-forward button for upstreaming right now, which I think
>> is good (everyone should have!) but the limited number of trusted
>> maintainers of core infrastructure code makes bottlenecks form
>> around these drivers where review is really needed and deep queues
>> of patches form. Sorry.
>
>
> That's one of the reasons why I prefer v5 of my patch instead of v7.  v5
> does not touch the core.  It's much less intrusive and has no risk of
> breaking other drivers.  I can't say that about v7.

The more intrusive design is on my request so I will look at it in detail
ASAP. I took a quick look and liked what I saw, I just need to make
sure about the details. Also it'd be nice to have a nod from Bj?rn.

The main reason for some of the work is ACPI, am I right?

Timur could you look quickly at the series posted by Andy Shevchenko
(6 patches prefixed gpiolib: acpi: ) for augmenting ACPI GPIOs in the core?
Especially patch 5 and 6 which introduce the ability to add quirks in the
core.

I'd like to get some ARM-based people to look at it to make sure we
those systems can also quirk their GPIOs if need be.

Yours,
Linus Walleij
