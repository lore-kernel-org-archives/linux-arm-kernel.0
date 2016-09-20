From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2016 23:54:48 +0200
Subject: [PATCH] pinctrl: mvebu: orion5x: Generalise mv88f5181l support
 for 88f5181
In-Reply-To: <20160920162635.4195-1-gregory.clement@free-electrons.com>
References: <20160920162635.4195-1-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdbo6JmR=K58KQ_J0Gd5_gLqub65watU-iEabQ0rWdeVpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 6:26 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Jamie Lentin <jm@lentin.co.uk>
>
> As far as I'm aware the mv88f5181-b1 and mv88f5181l are the same at the
> pinctrl level, so re-use the definitions for both.
>
> [gregory.clement at free-electrons.com: fix commit title]
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Is this the patch from your pull request?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Or do you prefer that I take it into the pinctrl tree?

Yours,
Linus Walleij
