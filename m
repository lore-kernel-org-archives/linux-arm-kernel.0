From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Aug 2017 14:43:49 +0200
Subject: [PATCH 00/17] constify pinconf_ops, pinctrl_ops,
 and pinmux_ops structures
In-Reply-To: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZA_Nff+5Gk9wexoroX2=-tMzNJFVQbWmV8nhWooEwWbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:06 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> These structures are only stored in fields of a pinctrl_desc
> structure that are const. Make the structures const as well.
>
> Done with the help of Coccinelle.

Thanks Julia, all patches applied with relevant ACKs collected.

Yours,
Linus Walleij
