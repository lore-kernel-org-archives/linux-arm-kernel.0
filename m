From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:29:58 +0200
Subject: [PATCH 3/5] pinctrl: handle zero found dt pinconfig properties
 better
In-Reply-To: <201306141743.21365.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306141743.21365.heiko@sntech.de>
Message-ID: <CACRpkdbHYRriNvM+1btEkGaL2J_vNXCGo_m_P6oLG_Ymrbz4Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 5:43 PM, Heiko St?bner <heiko@sntech.de> wrote:

> This adds a shortcut when no valid pinconf properties are found
> in the parsed dt node, to set the values immediately and return.
>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
