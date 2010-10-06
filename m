From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 6 Oct 2010 11:16:31 +0200
Subject: [PATCH] spi/pl022: get rid of chipinfo dev pointer
In-Reply-To: <1285926452-8636-1-git-send-email-linus.walleij@stericsson.com>
References: <1285926452-8636-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTikJXpYXAxYD0VEc4GszT-QOxvVhES1+QerzAi9T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/1 Linus Walleij <linus.walleij@stericsson.com>:

> What is the dev pointer doing inside the platform data anyway.
> We have another pointer to the actual device at hand, use that.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Note: this is based off Kevin Wells patch for using the proper
> modebits since I expect that to go in first. If you want this to
> go before that patch, tell me and we both have to rebase.

Obviously it needs the ACKed DMA support patch as well.
Tell me if you want the patch stack spun around either direction,
things are stacking up a bit...

Yours,
Linus Walleij
