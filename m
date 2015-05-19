From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:11:02 +0200
Subject: [PATCH v2 01/11] dt-bindings: mediatek: Modify pinctrl bindings
 for mt6397.
In-Reply-To: <1432015882-8646-2-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-2-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZhSUZVKZr5nWXX-15+GwrqrKkW_u_+cQDH1pO_NrayEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 8:11 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since 6397 is no need to support interrupt controller,
> moving interrupt controller relate property to optional list.
> Also adding mt8173 and mt8127 to bindings.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Backed out earlier applied MTK patches and applied
this one instead, sorry too intense development...

Yours,
Linus Walleij
