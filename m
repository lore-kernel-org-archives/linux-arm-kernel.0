From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:23:54 +0200
Subject: [PATCH 21/22] ARM: ux500: Add all encompassing sound node to the
 Snowball Device Tree
In-Reply-To: <1344527268-5964-22-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-22-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZzq_zrC247iFFf4UE-5hXZzTxZwqqDTDy6j2ez4ArfEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This is where we link together all of the SoC sound components for
> a given platform. This all encompassing sound node is only found
> in the very lowest hierarchical DTS file, since the component mix may
> well change from board variant to board variant.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
