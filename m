From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 09:00:29 +0100
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <20121211213916.GB7214@pratikp-linux.qualcomm.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
 <20121211213916.GB7214@pratikp-linux.qualcomm.com>
Message-ID: <CACRpkdYYhAyLXJL6ns5mfFQOethihabfPpPuqz9Unq_SCJqLig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 10:39 PM, Pratik Patel <pratikp@codeaurora.org> wrote:

> Thanks for the quick evaluation. I will be working on cleaning up
> the drivers for upstream submission in the coming weeks.

This is exactly what I like to hear :-)

Can you preserver the CC line from this mail on your subsequent
posts so the involved experts can follow the discussions?

It seems like keeping this new framework in drivers/ and actually refactoring
the old stuff in arch/arm/kernel/etm.c etc is the way forward, but doing that
may require some patch to support the old style of things. As the older code
may be stale maybe just depend on !CONFIG_OC_ETM is a way forward.

Yours,
Linus Walleij
