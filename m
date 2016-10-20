From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 14:51:11 +0200
Subject: [PATCH v2 3/9] pinctrl: sunxi: Handle bias disable
In-Reply-To: <6f9d91647b9f05a1df5d655a49965b671ba04b71.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <6f9d91647b9f05a1df5d655a49965b671ba04b71.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYq4betoUSJK8NtdMt6WJi1UREeOja0kZoFyyuCTvhBJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 5:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> So far, putting NO_PULL in allwinner,pull was ignored, behaving like if
> that property was not there at all.
>
> Obviously, this is not the right thing to do, and in that case, we really
> need to just disable the bias.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
