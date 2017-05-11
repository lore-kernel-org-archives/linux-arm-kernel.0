From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 09:32:07 +0200
Subject: [PATCH v2] pinctrl: rockchip: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1493383835-1959-1-git-send-email-yamada.masahiro@socionext.com>
References: <1493383835-1959-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbSLRpXKgFh81XfB13xEc9_sibscM18KCkAEBHjjgF8aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 2:50 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> of_device_id::data is an opaque pointer.  No explicit cast is needed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>
> Changes in v2:
>   - Rebase on pinctrl subsystem tree

Patch applied for v4.13.

Yours,
Linus Walleij
