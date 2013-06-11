From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Jun 2013 10:48:47 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <201306102140.29918.heiko@sntech.de>
References: <201306102139.32444.heiko@sntech.de>
 <201306102140.29918.heiko@sntech.de>
Message-ID: <CACRpkdbEkP-UbwsMD7bDokDU_Swa4_mCQcxu+Z7AeUfdYZ8xaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 9:40 PM, Heiko St?bner <heiko@sntech.de> wrote:

> pinconf_generic_parse_dt_config() takes a node as input and generates an
> array of generic pinconfig values from the properties of this node.
>
> As I couldn't find a mechanism to count the number of properties of a node
> the function uses internally an array to accept one of parameter and copies
> the real present options to a smaller variable at its end.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Looks good, patch applied!

> +Supported configuration parameters are:
> +
> +bias-disable           - disable any pin bias
> +bias-high-impedance    - high impedance mode ("third-state", "floating")
(...)

We should probably document applicable arguments to these,
and indicate which ones are boolean. But that can be fixed up
later.

Yours,
Linus Walleij
