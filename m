From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:41:14 +0100
Subject: [PATCH] pinctrl: uniphier: refactor drive strength get/set
 functions
In-Reply-To: <1515573254-8894-1-git-send-email-yamada.masahiro@socionext.com>
References: <1515573254-8894-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdY1aYZZFp=WgKhMUWk9v8DCmumwN6whYHQSPFjDFSY4vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 9:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> There is code duplication between uniphier_conf_pin_drive_get() and
> uniphier_conf_pin_drive_set().  Factor out the common code into
> uniphier_conf_get_drvctrl_data().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
