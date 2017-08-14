From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Aug 2017 14:40:31 +0200
Subject: [PATCH] ste_dma40: make stedma40_chan_cfg const
In-Reply-To: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
References: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
Message-ID: <CACRpkdbRtvE2+w1z1S=4d8gReomsMV1PjaB9Oux29tRGoP9nwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 13, 2017 at 3:23 PM, Bhumika Goyal <bhumirks@gmail.com> wrote:

> Make these const as they are only used during a copy operation.
> Done using Coccinelle.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
