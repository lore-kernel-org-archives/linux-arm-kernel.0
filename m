From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 10:57:02 +0200
Subject: [PATCH 07/10] arm64: dts: mt8173-evb: Add pinctrl/GPIO node for
 mt6397.
In-Reply-To: <1431567346-33780-8-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-8-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZ5kL8-g89dmBWfyeK5XM0oOKPjFvv2+=j_fVrjsKWi0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 3:35 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Add pinctrl and GPIO node to mt8173-evb.dts.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This needs to go through the ARM SoC tree, or I need an ACK from
some ARM SoC maintainer if I should take it through the pinctrl
tree.

Since there is a build dependency on the header in pinctrl
ARM SoC would need to pull in some immutable branch
from my tree to take this patch.

Yours,
Linus Walleij
