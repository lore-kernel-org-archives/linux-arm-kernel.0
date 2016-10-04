From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Oct 2016 14:14:11 +0200
Subject: [PATCH 2/2] mfd: ab8500-debugfs: remove unused function
In-Reply-To: <1474695413-30460-1-git-send-email-baoyou.xie@linaro.org>
References: <1474695413-30460-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CACRpkdZFnPC7NqAPbJH+QqmuRbOFhWEXEGkmdw_KUdVH=hFDwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 7:36 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:

> We get 1 warning when building kernel with W=1:
> drivers/mfd/ab8500-debugfs.c:1395:6: warning: no previous prototype for 'ab8500_dump_all_banks_to_mem' [-Wmissing-prototypes]
>
> In fact, this function is called by no one and not exported,
> so this patch removes it.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
