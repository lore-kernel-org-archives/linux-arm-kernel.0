From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 19:16:54 +0100
Subject: [PATCH 0/9] drivers: mailbox: framework creation
In-Reply-To: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 2:10 PM, Loic Pallardy
<loic.pallardy-ext@stericsson.com> wrote:

> OMAP and ST-Ericsson platforms are both using mailbox to communicate
> with some coprocessors.
> Based on OMAP existing mailbox framework, this series proposes a
> generic framework, living under drivers/mailbox.

I like this patch series so you have my Acked-by.

Since it's a new subsystem and affects a few ARM architectures can
we merge this into the ARM SoC tree once we have consensus,
so we get some rotation in linux-next that way?

Olof/Arnd?

Yours,
Linus Walleij
