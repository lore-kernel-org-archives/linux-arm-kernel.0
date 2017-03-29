From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Mar 2017 03:45:57 +0200
Subject: [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to use devm_*()
In-Reply-To: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
Message-ID: <CACRpkdYHJinMhgUQLe3vf6P8hj3o_3ASi8pT+dtM5JtrE5ccJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 4:41 PM, Leo Yan <leo.yan@linaro.org> wrote:

> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
