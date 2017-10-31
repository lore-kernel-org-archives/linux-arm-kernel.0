From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 09:44:40 +0100
Subject: [PATCH v2 1/3] pinctrl: sunxi: Introduce the strict flag
In-Reply-To: <c764ce12c83daefabaaea6a2df293c68f078c5e2.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
 <c764ce12c83daefabaaea6a2df293c68f078c5e2.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdavwWk4LBEzm3=0K1kMx2Nc4SoYE0kZw3pqDcfr9-st+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 10:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Our pinctrl device should have had strict set all along. However, it wasn't
> the case, and most of our old device trees also have a pinctrl group in
> addition to the GPIOs properties, which mean that we can't really turn it
> on now.
>
> All our new SoCs don't have that group, so we should still enable that mode
> on the newer one though.
>
> In order to enable it by default, add a flag that will allow to disable
> that mode that should be set by pinctrl drivers that cannot be migrated.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
