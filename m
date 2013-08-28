From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 14:18:07 +0200
Subject: [PATCH v5 3/3] pinctrl: mvebu: Convert to use
 devm_ioremap_resource
In-Reply-To: <1377578476-3268-4-git-send-email-jszhang@marvell.com>
References: <1377578476-3268-1-git-send-email-jszhang@marvell.com>
 <1377578476-3268-4-git-send-email-jszhang@marvell.com>
Message-ID: <CACRpkdZ_RJpqm-TzuEt7_g7kaPhQJ3PZPK1kYxp3UkSZNSbX-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 6:41 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> The resource mapped by of_iomap() isn't unmapped in error path. This
> patch fix the resource leakage by using devm_ioremap_resource() instead
> of of_iomap().
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Patch applied.

Yours,
Linus Walleij
