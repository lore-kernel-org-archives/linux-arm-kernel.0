From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Sep 2014 14:27:17 +0200
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <20140901121700.GC6617@leverpostej>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
 <20140725152401.GA21830@leverpostej>
 <CACRpkdaugAmVt5CF194xd+eVyz=Yfir6Jz0k9h4VSvSWLkKPRQ@mail.gmail.com>
 <20140901121700.GC6617@leverpostej>
Message-ID: <CACRpkdYoqhiLqVMqrrUxZEq-c63NuDT--FVWs3j_5b1BC24FeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 1, 2014 at 2:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Sep 01, 2014 at 12:52:49PM +0100, Linus Walleij wrote:

>> Should use the string "arm,arm1176jzf-devchip-gic"?
>
> That sounds fine to me.
>
> The document you've linked to says the GIC is derived from the MPCore
> GIC, so I'd place "arm,arm11mp-gic" as a fallback entry in the
> compatible list. Until we need to distinguish the two the driver
> shouldn't need to be updated.

Well the driver doesn't have a IRQCHIP_DECLARE() for arm11mp-gic
either so I'll have to add that instead.

Yours,
Linus Walleij
