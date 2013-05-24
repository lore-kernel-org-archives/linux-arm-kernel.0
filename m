From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 09:54:49 +0200
Subject: [PATCH v3 2/2] pinctrl: imx: add MVF600 support to imx pinctrl
 framework
In-Reply-To: <1368685224-17915-2-git-send-email-b35083@freescale.com>
References: <1368685224-17915-1-git-send-email-b35083@freescale.com>
 <1368685224-17915-2-git-send-email-b35083@freescale.com>
Message-ID: <CACRpkdao66R2jNoJnJY65iHberorKLe2FXW6BJfDes1fvYmCVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 8:20 AM, Jingchang Lu <b35083@freescale.com> wrote:

> On some platforms such as MVF600, offset of mux and pad ctrl register
> may be zero, and the mux_mode and config_val are in one 32-bit register.
> This patch adds support to imx core pinctrl framework to handle these
> cases.
>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v3:
>   add ZERO_OFFSET_VALID flag to handle register offset from zero on mvf600.
>   add SHARE_MUX_CONF_REG flag to handle mux mode and config value in one 32-bit
> register in mvf600.

Patch applied with Shawn's ACK, thanks!

Yours,
Linus Walleij
