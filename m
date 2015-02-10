From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Feb 2015 16:21:27 +0800
Subject: [PATCH 1/3] arm64: mediatek: Add config option for mt8173.
In-Reply-To: <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdYbpf-RaCeA=S1xwApGnRnTy2FtCNV79y8eqA6LP_hZDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 3:13 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> The upcoming MTK pinctrl driver have a big pin table for each SoC,
> and we don't want to bloat the kernel binary if we don't need it.
> Add config options so we can build for one SoC only.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Take this through the ARM SoC tree with the rest of the mediatek
SoC stuff.

Yours,
Linus Walleij
