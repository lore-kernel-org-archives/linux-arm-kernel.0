From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 14:46:18 -0700
Subject: [PATCH v8 7/7] pinctrl: freescale: imx: imx7d iomuxc-lpsr
 devicetree bindings
In-Reply-To: <1443629469-12294-7-git-send-email-aalonso@freescale.com>
References: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
 <1443629469-12294-7-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdaht884ZBBaUoibGVRx8aGwHdimt2r9cz48=MZTpo2qaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 9:11 AM, Adrian Alonso <aalonso@freescale.com> wrote:

> Add iomuxc-lpsr devicetree bindings documentation
> Provide documentation context as well an example on
> pheriperals that could use pad from either iomuxc controller
> supported by iMX7D SoC
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: New patch on imx7d iomuxc-lpsr patch series
> Changes for V3: Add shared input select register notes
> Changes for V4: Resend
> Changes for V5:
> - Fix spell error
> - Remove references of SHARE_INPUT_SELECT_REG flag
> Changes for V6: Resend
> Changes for V7: Resend
> Changes for V8: Correct SDA pad example

Patch applied. Assuming Shawn's old ACK is valid so attached it,
else beat me up Shawn.

Yours,
Linus Walleij
