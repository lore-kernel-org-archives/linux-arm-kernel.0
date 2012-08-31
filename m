From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 01:32:55 +0200
Subject: [PATCH 0/4] clk: Support for smp_twd clock for ux500
In-Reply-To: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbymhVyWrvRpoZHYp9FanO1As0dnEVJ5tSQm9AGE6-gBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 2:21 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> To implement support for the smp_twd clock for ux500 several steps
> was needed. This patchseries has also proposed some new changes in the
> common clock core, which the ux500 smp_twd clock definition are
> relying on.

This is a great series,
Acked-by: Linus Walleij <linus.walleij@linaro.org>
For the ux500 parts.

Mike it'd be great if you could merge this once you have the semantics
of [1/4] sorted out with Ulf.

Yours,
Linus Walleij
