From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Sep 2013 11:34:34 +0200
Subject: [PATCH 2/2] dma: ste_dma40: Fix potential null pointer dereference
In-Reply-To: <1378109699-25245-2-git-send-email-sachin.kamat@linaro.org>
References: <1378109699-25245-1-git-send-email-sachin.kamat@linaro.org>
 <1378109699-25245-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CACRpkdZW-GJeQnm9btn+WzNP9ZqqjRAyxBriJoL4E7OjztA4LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 2, 2013 at 10:14 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> kcalloc can return NULL. Check the pointer before dereferencing.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess Vinod can take this into fixes for v3.12?

Yours,
Linus Walleij
