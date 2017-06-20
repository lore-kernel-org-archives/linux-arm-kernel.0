From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jun 2017 11:34:24 +0200
Subject: [PATCH 1/2] pinctrl: uniphier: fix WARN_ON() of pingroups dump on
 LD11
In-Reply-To: <1497415770-17741-1-git-send-email-yamada.masahiro@socionext.com>
References: <1497415770-17741-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdaw0rydYJnLZWSRLMg=gCCH69ZFwizKHf=mzBv1q8fgJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 6:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The pingroups dump of debugfs hits WARN_ON() in pinctrl_groups_show().
> Filling non-existing ports with '-1' turned out a bad idea.
>
> Fixes: 70f2f9c4cf25 ("pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
