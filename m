From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:55:00 +0200
Subject: [PATCH 13/18] ARM: u300: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-14-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-14-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdY0Ka6QNmM10hfDd5aLfoZ_mZT3W=x6dS4wcixabyPbuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 12:31 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
