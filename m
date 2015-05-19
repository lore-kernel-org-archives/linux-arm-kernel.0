From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 10:50:41 +0200
Subject: [PATCH 02/10] pinctrl: mediatek: add
 mtk_pctrl_spec_pull_set_samereg common code
In-Reply-To: <1431567346-33780-3-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-3-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdbOxiWRF3fvA8m20sU5SkjL9LP66SOhrApR__eE8p_SjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 3:35 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> Several mediatek soc use similar pull setting procedure as mt8173,
> the pupd enable and resistance setting are in the same register.
> Add common code mtk_pctrl_spec_pull_set_samereg out of spec_pull_set
> in mt8173 to handle this case, so future soc driver can use it.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
