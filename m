From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 10:43:57 +0100
Subject: [PATCH 2/3] pinctrl: meson-gxl: Fix inverted registers and add
 missing pins
In-Reply-To: <1488893462-7016-3-git-send-email-narmstrong@baylibre.com>
References: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
 <1488893462-7016-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdZ+x6vZQKfCoKD3dn-XzAxBBwMy=HF1Zi7SqXFWv28rZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 2:31 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Fix some inverted bit numbers in some pinctrl groups and add missing pins
> and groups to be in pair with the GXBB pinctrl pins definition.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This does not apply on my fixes branch and possibly no other
v4.11-rc1-based branch. Can you please rebase it and resend?

I guess this also needs queueing for fixes?

Yours,
Linus Walleij
