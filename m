From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Apr 2017 10:03:43 +0200
Subject: [PATCH v2 07/30] arm: dts: mt7623: add pinctrl nodes to the
 mt7623 dtsi file
In-Reply-To: <1493198774-4478-8-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-8-git-send-email-sean.wang@mediatek.com>
Message-ID: <CACRpkda8bu3zT_kLWSbfx1SobHcQRxEOdJC=PEpW4=+LvcmiMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:25 AM,  <sean.wang@mediatek.com> wrote:

> From: John Crispin <john@phrozen.org>
>
> Add pin controller node to the mt7623.dtsi file
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
(...)
> +       pio: pinctrl at 10005000 {
> +               compatible = "mediatek,mt7623-pinctrl",
> +                            "mediatek,mt2701-pinctrl";

This looks right. And that is why we should not delete that compatible
string.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
