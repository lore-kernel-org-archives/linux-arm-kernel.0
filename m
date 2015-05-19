From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:15:46 +0200
Subject: [PATCH v2 05/11] pinctrl: mediatek: add ies/smt control to common
 code.
In-Reply-To: <1432015882-8646-6-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-6-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdb_+tvCETd1V=hS-FfF6ZM0B63S2uzGSmbihiy=S9QDJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 8:11 AM, Hongzhou Yang
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

Applied this version instead.

Yours,
Linus Walleij
