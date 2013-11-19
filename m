From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 11:08:09 +0100
Subject: [PATCH 4/9] ARM: sa1100: convert gpio driver to be a proper
 platform driver
In-Reply-To: <1384505280-25389-5-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <1384505280-25389-5-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdYb6KAG2i-NH2iAmYvtGDnhOgO9CZxmYsNPJXN6qqkOoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 9:47 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Start cleaning up/refreshing SA1100 GPIO driver.
> * Changed to bind through device model.
> * Replaced direct register access with readl/writel.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you want to merge this one through Russell's tree
with the rest of the patches.

Yours,
Linus Walleij
