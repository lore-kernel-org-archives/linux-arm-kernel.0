From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 13:40:58 +0200
Subject: [PATCH v2 1/5] pinctrl: rockchip: separate different sub-types
 more
In-Reply-To: <201310160107.21147.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
 <201310160107.21147.heiko@sntech.de>
Message-ID: <CACRpkdYQTy4mtBXfQqX=UnDxx-avAdjRYLnnEuKKEOBhMUxs3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 1:07 AM, Heiko St?bner <heiko@sntech.de> wrote:

> Further investigation of the different Rockchip SoCs showed that
> the differences especially in the pull settings are quite deep.
> As further patches will show, the register layout for the pulls of
> the rk3188 is quite strange. Also it is to assume, that later
> Rockchip SoCs may introduce even more quirks in this regard, making
> it hard to support all of those using the current generic pull_*
> variables.
>
> Therefore move the driver to hold the type of controller in an enum
> and do the handling according to it in the necessary places. Also
> instead of calculating the register in the get and set pull functions
> move it to a type-specific callback.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
