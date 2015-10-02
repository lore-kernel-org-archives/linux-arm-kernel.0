From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 14:37:45 -0700
Subject: [PATCH v6 3/6] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <1443215162-13716-3-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
 <1443215162-13716-3-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdaeNDrG4NR=A3UV4Q=vHNSGbA3+tCELqOMiZSFSPa0sgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 2:05 PM, Adrian Alonso <aalonso@freescale.com> wrote:

> Allow mux_reg offset zero to be a valid pin_id, on imx7d
> mux_conf reg offset is zero for iomuxc-lspr controller
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: Resend
> Changes for V3: Resend
> Changes for V4: Simplify pin_id assigment when ZERO_OFFSET_VALID is set
> Changes for V5:
> - Drop patch pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
> - Allow mux_reg ZERO OFFSET as pin_id
> Changes for V6: Restore ZERO_OFFSET_VALID flag

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
