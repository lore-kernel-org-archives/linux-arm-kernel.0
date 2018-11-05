From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 5 Nov 2018 13:46:48 -0600
Subject: [PATCH V4 05/10] dt-bindings: pinctrl: imx7ulp: back to imx
 legacy binding for consistency
In-Reply-To: <1541149669-10857-6-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
 <1541149669-10857-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAL_JsqJN-RqxLzchCUJbCm3uxY22VZMZHVdqXAJSzhLzsBgHZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2018 at 4:13 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
>
> We already had an earlier conclusion that all new i.MX Socs will keep
> using the legacy i.MX Pinctrl bindings instead of generic pin config.
> However, MX7ULP generic pin config binding support has already been in
> tree before that time. Per SoC maintainers' suggestions, in order to
> get a better consistency for all i.MX devices, we'd like to go back to
> imx legacy binding for MX7ULP as well.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
>  v3: new patch
> ---
>  .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       | 66 ++++++++++------------
>  1 file changed, 29 insertions(+), 37 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
