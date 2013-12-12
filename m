From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 20:02:27 +0100
Subject: [PATCH 1/2] gpio: msm: Fix irq mask/unmask by writing bits
 instead of numbers
In-Reply-To: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
References: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdY8W8tGVH-Os5neeFfHWjojdB5fBbjgWcsWkiMyJj=YAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 12:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> We should be writing bits here but instead we're writing the
> numbers that correspond to the bits we want to write. Fix it by
> wrapping the numbers in the BIT() macro. This fixes gpios acting
> as interrupts.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

I've applied this for fixes and tagged for stable.
Bj?rn, Rohit: OK?

Yours,
Linus Walleij
