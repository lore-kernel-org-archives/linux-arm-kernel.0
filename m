From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Nov 2016 11:27:41 +0100
Subject: [PATCH 1/1] pinctrl: st: st_pctl_dt_parse_groups simplify
 expression
In-Reply-To: <20161105143515.4668-1-xypron.glpk@gmx.de>
References: <20161105143515.4668-1-xypron.glpk@gmx.de>
Message-ID: <CACRpkdaDV4FjOtUoSwCAmbOnQqn8NZZ_nD2tpRoVoSPVePtKyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2016 at 3:35 PM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> for_each_property_of_node(pins, pp) checks that pp is not NULL.
> So there is no need to check it inside the loop.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Patch applied with Patrice's ACK.

Yours,
Linus Walleij
