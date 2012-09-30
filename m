From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2012 23:43:33 +0200
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <20120930101418.GF6933@n2100.arm.linux.org.uk>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb+bnCzYV2Dzqou5kGyc1hrh0VT-pYXZm1auu4uik2GNg@mail.gmail.com>
 <20120930101418.GF6933@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaJx7sccJmCRhndGHz+NY9iUv39B2jmNb6DLC5WQuj5_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 12:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The real answer is to revert both commits to get the driver back to a
> sane state, before then progressing with the driver in a sane manner.
> This is what Ulf is doing.

Aha, mea culpa.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all of them, I'll read up on this exploding backlog and then Ulf
will hammer me at the office until I understand this stuff properly...

Yours,
Linus Walleij
