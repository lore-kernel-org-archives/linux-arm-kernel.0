From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Oct 2011 11:41:19 +0200
Subject: [PATCH] mmc: mmci: Do not release spinlock in request_end
In-Reply-To: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdb5pn=q+hQSsrTgKbCvuKR83vHn1iAfvzMFXQeAgv--+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 4:06 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> The patch "mmc: core: move ->request() call from atomic context",
> is the reason to why this change is possible. This simplifies the
> error handling code execution path quite a lot and potentially also
> fixes some error handling hang problems.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Adrian do you agree with this?

To me it looks correct,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
