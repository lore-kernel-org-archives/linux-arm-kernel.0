From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 09:46:18 +0100
Subject: [PATCH v2 3/3] pinctrl: sunxi: Enforce the strict mode by default
In-Reply-To: <b88debdc2ed1dd2488fad802be1a9e6f31bf67a4.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
 <b88debdc2ed1dd2488fad802be1a9e6f31bf67a4.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdaP_JwPpFd1iq6JgJSurfif24scJRzOeR3+hawKrs31hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 10:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The strict mode should always have been enabled on our driver, and leaving
> it unchecked just makes it harder to find a migration path as time passes.
>
> Let's enable it by default now so that hopefully the new SoCs should be
> safe.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
