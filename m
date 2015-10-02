From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 03:37:09 -0700
Subject: [PATCH v2 1/6] pinctrl: berlin: regmap as an extra argument of
 berlin_pinctrl_probe()
In-Reply-To: <1442829860-4647-2-git-send-email-jszhang@marvell.com>
References: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
 <1442829860-4647-2-git-send-email-jszhang@marvell.com>
Message-ID: <CACRpkdaJc_j1S=W2kropf52uRHfYmTXsZChPvMBLe=Cj67x5RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 3:04 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> Let berlin_pinctrl_probe() accepts an extra argument: regmap, this is to
> prepare for the next berlin4ct support, where we won't use simple-mfd
> any more.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Waiting for Antoine's review of this patch before applying.

Yours,
Linus Walleij
