From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 14:51:14 +0100
Subject: [PATCH 1/1] ARM: ux500: Disable Power Supply and Battery
 Management by default
In-Reply-To: <1358175470-5041-1-git-send-email-lee.jones@linaro.org>
References: <1358175470-5041-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYydqJ+BVsh7P411zCod+83f2pVV5tPsKfoWPYUnOVpDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 3:57 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The AB8500 Battery Management collection of drivers are more than a
> little bit broken. There is lots of work still on-going in that area
> and it's improving day by day; however, it's not ready to be enabled
> by default just yet.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Is this going for fixes (v3.8?)

For v3.9 I think you've submitted a whole lot of patches
actually fixing it up?

Anyway: Acked-by: Linus Walleij <linus.walleij@linaro.org>
since you certainly know the status of this driver better than
me.

Yours,
Linus Walleij
