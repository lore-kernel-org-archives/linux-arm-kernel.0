From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 14:47:56 +0200
Subject: [PATCH v2 1/9] pinctrl: sunxi: Rework the pin config building code
In-Reply-To: <709f95f6725453af12bc989ce9039df5aa252ea5.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <709f95f6725453af12bc989ce9039df5aa252ea5.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZwmD=Jfss2hgEDt3KvTwVvFXCd5VzRCnn9_pn8VUvxkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 5:45 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> In order to support more easily the generic pinctrl properties, rework the
> pinctrl maps configuration and split it into several sub-functions.
>
> One of the side-effects from that rework is that we only parse the pin
> configuration once, since it's going to be common to every pin, instead of
> having to parsing once for each pin.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
