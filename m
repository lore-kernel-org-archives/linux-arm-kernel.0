From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 11:37:04 +0100
Subject: [PATCH 3/4] pinctrl: samsung: Remove support for Exynos4415 (SoC
 not supported anymore)
In-Reply-To: <20170114123642.15581-4-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
 <20170114123642.15581-4-krzk@kernel.org>
Message-ID: <CACRpkdZh+kPUwf56XskzCUPh89h5a_2_-=EFw=NFKYY_zD4jfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 1:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Support for Exynos4415 is going away because there are no internal nor
> external users.
>
> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
> the platform cannot be instantiated so remove also the drivers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It can certainly be instantiated (from old DTBs...) but has
no DTS upstream. But I get what you mean.

Patch applied, if someone is unhappy they can always start
sending reverts.

Yours,
Linus Walleij
