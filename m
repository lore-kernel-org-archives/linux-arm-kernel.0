From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Nov 2015 22:35:39 +0100
Subject: [PATCH] pinctrl: mediatek: fix a memleak when do dt maps.
In-Reply-To: <1447799622-3340-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1447799622-3340-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZLA-qu8uzO-7HRnwR6h6y8Gkhw0rs8St8BXjfduUFykA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:33 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> configs will kmemdup to dup_configs in pictrl util function.
> So configs need to be freed.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Fix a memleak issue.
>  According to Yingjoe's comment, add return checek for pinconf_generic_parse_dt_config.

Patch applied with Yingjoe's review tag.

Yours,
Linus Walleij
