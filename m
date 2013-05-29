From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 20:36:42 +0200
Subject: [PATCH RESEND v3 1/2] pinctrl: imx: add VF610 support to imx
 pinctrl framework
In-Reply-To: <1369733528-25926-1-git-send-email-b35083@freescale.com>
References: <1369733528-25926-1-git-send-email-b35083@freescale.com>
Message-ID: <CACRpkdayEPreJKBUBK9abixN_M6O1QxGR2-ptErGXMcW4m+7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 11:32 AM, Jingchang Lu <b35083@freescale.com> wrote:

> On some platforms such as VF610, offset of mux and pad ctrl register
> may be zero, and the mux_mode and config_val are in one 32-bit register.
> This patch adds support to imx core pinctrl framework to handle these
> cases.
>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v3:
>   Add ZERO_OFFSET_VALID flag to handle register offset from zero on Vybrid vf610.
>   Add SHARE_MUX_CONF_REG flag to handle mux mode and config value in one 32-bit
> register on Vybrid vf610.

Patch applied with Shawn's ACK.

Thanks,
Linus Walleij
