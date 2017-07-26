From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 26 Jul 2017 17:55:47 -0500
Subject: [PATCH v6 1/3] Documentation: devicetree: add Freescale RNGC
 binding
In-Reply-To: <1500832146-8660-1-git-send-email-martin@kaiser.cx>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <1500832146-8660-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAL_Jsq+2Z94apqTsvs4HQdS49GdzT50XmPS4RvA7MDp_kK5Wow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 12:49 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> Add binding documentation for the Freescale RNGC found on
> some i.MX2/3 SoCs.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Changes in v6:
>   - be more precise about rngc and rngb
>   - get rid of mxc, rename the file to imx-rngc.txt
>   - reformat the compatible strings
>   - use RNGC instead of RNG
>   - clarify that clock is not optional (remove "should contain")
>
> Changes in v5:
>   none
>
> Changes in v4:
>   none
>
> Changes in v3:
>   - add compatible string for imx35
>   - remove imx5 from the commit message,
>     I couldn't find an i.MX SOC that has RNGC
>
> Changes in v2:
>   none
>
>  Documentation/devicetree/bindings/rng/imx-rngc.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/imx-rngc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
