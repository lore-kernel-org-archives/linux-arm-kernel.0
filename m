From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2016 12:50:24 +0200
Subject: [PATCH 3/3] ARM: dts: add Qualcomm APQ8060-based Dragonboard
In-Reply-To: <1465779498-11339-3-git-send-email-linus.walleij@linaro.org>
References: <1465779498-11339-1-git-send-email-linus.walleij@linaro.org>
 <1465779498-11339-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZsQJgv-zzPhcQcBxJPUwB4KMPfxsYnWmfH7is_g9z9Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 2:58 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This is the first Dragonboard based on APQ8060 and PM8058. It
> was produced in 2011 in cooperation between Qualcomm and
> BSQUARE.
>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I managed to get RPM and regulators working on this board, so I
will revise the series. Patch 1 & 2 will probably be the same but this
one will use proper regulators.

Yours,
Linus Walleij
