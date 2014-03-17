From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Mar 2014 08:38:58 +0100
Subject: [PATCH] pinctrl: msm: fix build bug
In-Reply-To: <201403151033.36878.arnd@arndb.de>
References: <201403151033.36878.arnd@arndb.de>
Message-ID: <CACRpkdYRmdzY3tQ-XJ3OVuDdPi3wMsaF8EaeT0qf6SUJWd021w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 10:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Commit 051a58b4622 "pinctrl: msm: Simplify msm_config_reg()
> and callers" rearranged code in the msm_config_reg function, but
> apparantly missed one line that was added in ed118a5fd9
> "pinctrl-msm: Support output-{high,low} configuration".
>
> This (untested) patch does the same respective change to
> resolve the conflict.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>

I think I've merged a similar patch the day it happened but
thanks anyway!

Yours,
Linus Walleij
