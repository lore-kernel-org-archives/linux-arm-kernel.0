From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 10:51:42 +0200
Subject: [PATCH 03/10] pinctrl: mediatek: add ies/smt control to common
 code.
In-Reply-To: <1431567346-33780-4-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-4-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdY9k7DoKne+qHji48yeq8Pb9Ah58z7Q7d4A67WZuMWypA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 3:35 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Input enable and smt setting have different register,
> modify code to fix it.
>
> Several mediatek soc use similar input enable/smt setting
> procedure as mt8173, some soc use generic input enable/smt
> setting, some soc has no input enable/smt setting. Adding
> common code to handle all those cases, so future soc driver
> can use it.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
