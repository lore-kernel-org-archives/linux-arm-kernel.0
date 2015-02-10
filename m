From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Feb 2015 16:20:38 +0800
Subject: [PATCH 2/3] arm64: mediatek: Add Pinctrl/GPIO/EINT driver for
 mt8173.
In-Reply-To: <1422342836-27689-3-git-send-email-hongzhou.yang@mediatek.com>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <1422342836-27689-3-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkda4TQDGDcGS7GZY97sTDHyt_yDdsBHhPru4Rqz815BsCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 3:13 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> Add mt8173 support using mediatek common pinctrl driver.
> MT8173 have a different ies_smt setting register than mt8135,
> so adding this support to common code.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied on top of the base 8135 series.

Yours,
Linus Walleij
