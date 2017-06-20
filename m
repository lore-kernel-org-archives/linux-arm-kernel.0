From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jun 2017 11:35:29 +0200
Subject: [PATCH 2/2] pinctrl: uniphier: fix WARN_ON() of pingroups dump on
 LD20
In-Reply-To: <1497415770-17741-2-git-send-email-yamada.masahiro@socionext.com>
References: <1497415770-17741-1-git-send-email-yamada.masahiro@socionext.com>
 <1497415770-17741-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdavW1WGHzW9et9SgEOVe+oV71FZCONEFSL3oaYA3_-Lyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 6:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The pingroups dump of debugfs hits WARN_ON() in pinctrl_groups_show().
> Filling non-existing ports with '-1' turned out a bad idea.
>
> Fixes: 336306ee1f2d ("pinctrl: uniphier: add UniPhier PH1-LD20 pinctrl driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
