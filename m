From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Feb 2016 14:56:07 +0100
Subject: [PATCH 1/2] pinctrl: mediatek: fix direction control issue
In-Reply-To: <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
 <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkdY5e-1mTOzPVUvPEJyxLBVxZRQw6Gqui1pAno96_RWq8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 2:24 AM, Biao Huang <biao.huang@mediatek.com> wrote:

> Since input-enable/disable and input-schmitt-enable/disable are
> workable when gpio direction is input, so add direction setting
> when do input-enable/disable and input-schmitt-enable/disable
> properties.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

This patch applied for fixes. I see now that it was part of the
mt2701 patch set, so sorry for missing it...

Yours,
Linus Walleij
