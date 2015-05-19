From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:14:34 +0200
Subject: [PATCH v2 04/11] pinctrl: mediatek: add
 mtk_pctrl_spec_pull_set_samereg common code
In-Reply-To: <1432015882-8646-5-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-5-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdYRu+ZWs5zqENJ0msu=wYbXposOiKp7HLz0ZdQZ0hQc6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 8:11 AM, Hongzhou Yang
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

Applied this version instead.

Yours,
Linus Walleij
