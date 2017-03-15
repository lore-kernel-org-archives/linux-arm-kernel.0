From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 14:45:20 +0100
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <0eb09039-17c4-5c00-0501-812d4de1ab4a@samsung.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
 <20170205155849.4362-1-weiyj.lk@gmail.com>
 <CGME20170213145008epcas3p119bdd6f76468a00fb8d796308ad37698@epcas3p1.samsung.com>
 <CACRpkda0BYLNpPFwpNaEMdeyx61KDUQz_6Y=FQj340pViFjVVQ@mail.gmail.com>
 <c4dd122b-0312-fcca-08e2-4d4586949a88@samsung.com>
 <CACRpkda1tALy3rmk7FebnR3Xg4WOuUc0Gv1xAmxkd+RLhJ_1VQ@mail.gmail.com>
 <0eb09039-17c4-5c00-0501-812d4de1ab4a@samsung.com>
Message-ID: <CACRpkdbY9SJhoqmMQBSc169SgVagcrPb9DaYnLXT0atLc1pH1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 11:44 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:

> I have posted proper fix some times ago[1], no need to revert.
>
> [1]: https://www.spinics.net/lists/linux-samsung-soc/msg58395.html

OK fixed that now.

Unreverted the revert, applied your patch.

Yours,
Linus Walleij
