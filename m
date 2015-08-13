From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 14:58:59 +0200
Subject: [PATCH] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <1439453936-8315-1-git-send-email-maoguang.meng@mediatek.com>
References: <1439453936-8315-1-git-send-email-maoguang.meng@mediatek.com>
Message-ID: <CACRpkdYKsUd4OSLJTPYZPmnLZfKQhj_UXmKtrBjKj5N4E8od2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 10:18 AM,  <maoguang.meng@mediatek.com> wrote:

> From: Maoguang Meng <maoguang.meng@mediatek.com>
>
> This patch implement irq_set_wake to get who is wakeup source and
> setup on suspend resume.
>
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
>
> ---
> changes since v2:
> -modify irq_wake to handle irq wakeup source.
> -allocate two buffers separately.
> -fix some codestyle.
>
> Changes since v1:
> -implement irq_wake handler.

Waiting for Hongzhu's ACK on this patch.

Yours,
Linus Walleij
