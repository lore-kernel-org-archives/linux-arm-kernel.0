From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Mar 2018 03:58:00 +0100
Subject: [PATCH v4 0/5] PINCTRL: Mediatek pinctrl driver for mt2712
In-Reply-To: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <CACRpkdZHuNytoq_PnLJa5SWJzPruMC29XE7GH_JxsH0uZmBabQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 3:58 AM, Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This series includes five patches:
> 1.Add mt2712 pintcrl head file.
> 2.Add mt2712 pinctrl device node.
> 3.Add mt2712 pinctrl driver.
> 4.Support bias-disable of generic and special pins simultaneously.
> 5.fix check warnings.
>
> Changes in patch v4:
> 1)fix check warnings for mt2712.
> 2)add fix check warnings patch for other ICs.

This looks good to me.

Can I get some ACK/Reviewed-by's from Sean so I can
merge the driver for v4.17?

Yours,
Linus Walleij
