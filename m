From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 14:44:19 -0700
Subject: [PATCH v8 6/7] pinctrl: freescale: imx7d: support iomux lpsr
 controller
In-Reply-To: <1443629469-12294-6-git-send-email-aalonso@freescale.com>
References: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
 <1443629469-12294-6-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdbOg4EYUV9DreWAxqi_NfGXX6k+-jvnJQogRPL7JeJ1Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 9:11 AM, Adrian Alonso <aalonso@freescale.com> wrote:

> iMX7D has two iomuxc controllers, iomuxc controller similar as
> previous iMX SoC generation and iomuxc-lpsr which provides low
> power state rentetion capabilities on gpios that are part of
> iomuxc-lpsr
>
> Add iomuxc-lpsr gpio group id's
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: Add imx7d_lpsr_pads enums
> Changes for V3: Resend
> Changes for V4: Resend
> Changes for V5: Remove flags SHARE_INPUT_SELECT_REG and ZERO_OFFSET_VALID.
> Changes for V6: Restore ZERO_OFFSET_VALID flag.
> Changes for V7: Resend
> Changes for V8: Resend

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
