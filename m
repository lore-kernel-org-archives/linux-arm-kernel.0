From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jul 2017 15:13:40 +0200
Subject: [PATCH] pinctrl: zte: fix dereference of 'data' in zx_set_mux()
In-Reply-To: <1498880736-18143-1-git-send-email-shawnguo@kernel.org>
References: <1498880736-18143-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CACRpkda31aW5YpFefGe3R8mWmMJ-iPF7UMB8t-tqPxhnihkWEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 1, 2017 at 5:45 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> From: Shawn Guo <shawn.guo@linaro.org>
>
> It fixes the following Smatch complaint:
>
> drivers/pinctrl/zte/pinctrl-zx.c:76 zx_set_mux()
> warn: variable dereferenced before check 'data' (see line 67)
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: cbff0c4d27f4 ("pinctrl: add ZTE ZX pinctrl driver support")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied for fixes.

Yours,
Linus Walleij
