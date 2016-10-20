From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 14:57:57 +0200
Subject: [PATCH v2 8/9] ARM: sunxi: Remove useless allwinner, pull property
In-Reply-To: <b643d1e525835365a6ae63bcd065cb3650a839d6.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <b643d1e525835365a6ae63bcd065cb3650a839d6.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbNVPobGYK5xpj9RMLS6goQo5+SHsPRNOGnsHNmWiv9ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 5:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The allwinner,pull property set to NO_PULL was really considered our
> default (and wasn't even changing the default value in the code).
>
> Remove these properties to make it obvious that we do not set anything in
> such a case.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
