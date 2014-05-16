From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 May 2014 15:40:07 +0200
Subject: [PATCH] pinctrl: sunxi: Enable the pinctrl Kconfig options by
 default
In-Reply-To: <1399994597-15177-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399994597-15177-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdb2gzpftp3PWkr40v1CZm2J=SmnY9Mb=5S-AJr+YXgkNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 5:23 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Enable the freshly introduced Kconfig options whenever their matching
> architecture is enabled.
>
> Since the Kconfig symbols for these machines are going through a different
> tree, keep PINCTRL_SUNXI around for the moment to avoid breaking the defconfig.
> It should be removed eventually.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

OK patch applied.

Yours,
Linus Walleij
