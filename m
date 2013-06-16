From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:28:37 +0200
Subject: [PATCH 2/5] pinctrl: clarify some dt pinconfig options
In-Reply-To: <201306141742.49923.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306141742.49923.heiko@sntech.de>
Message-ID: <CACRpkdYiMNJUtz5NmaJu-XOdfErC4FGCP8+_VwX-=2MQbsPfuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 5:42 PM, Heiko St?bner <heiko@sntech.de> wrote:

> The bias-pull-* options use values > 0 to indicate that the pull should
> be activated and optionally also indicate the strength of the pull.
> Therefore use an default value of 1 for these options.
>
> Split the low-power-mode option into low-power-enable and -disable.
>
> Update the documentation to describe the param arguments better.
>
> Wrong default options
> Reported-by: James Hogan <james.hogan@imgtec.com>
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
