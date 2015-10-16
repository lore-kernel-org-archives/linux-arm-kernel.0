From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Oct 2015 16:12:53 +0200
Subject: [PATCH v6 2/7] pinctrl: berlin: Make berlin pinctrl driver
 visible if COMPILE_TEST=y
In-Reply-To: <1444981032-4401-3-git-send-email-jszhang@marvell.com>
References: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
 <1444981032-4401-3-git-send-email-jszhang@marvell.com>
Message-ID: <CACRpkdbFLWwB_OXjXTbbKZA9UeTnH4HOzhVhfGHWE_S4xE1y8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 9:37 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> It is good to allow berlin pinctrl driver to build with COMPILE_TEST, so
> make the it menu visible when compile-testing.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
