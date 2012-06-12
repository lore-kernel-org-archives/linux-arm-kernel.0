From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 18:37:48 +0200
Subject: [PATCH 1/2] clockevents: add an optional frequency update function
In-Reply-To: <1336479469-9246-1-git-send-email-linus.walleij@stericsson.com>
References: <1336479469-9246-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdYUJzhHVhYyzM-PVz41tbUv7=gF2h-4xePh3uryLu8CYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 2:17 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> For some clockevents, especially for periodic ones, we get a
> problem when the frequency of the clock driving the event
> changes. We previously have a solution for one-shot events
> that will simply reprogram the next event. This introduces
> an optional callback so that drivers can update constant
> timer latch values derived from HZ.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Poke Thomas on this - are you happy with this patch?
If you ACK it I can try to submit it to Russell's patch tracker
with 2/2 for v3.6.

Yours,
Linus Walleij
