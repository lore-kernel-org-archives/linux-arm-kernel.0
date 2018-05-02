From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 14:24:13 +0200
Subject: [PATCH 3/6] pinctrl: imx: use seq_puts() instead of seq_printf()
In-Reply-To: <1524855713-15527-4-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdZ-GkW5KR=7CdT2RTb1VRpr1bpmf_HNZKu0m5f0DVaWaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> For a constant format without additional arguments, use seq_puts()
> instead of seq_printf(). Also, it fixes the following checkpatch
> warning.
>
> WARNING: Prefer seq_puts to seq_printf
> +               seq_printf(s, "N/A");
>
> WARNING: Prefer seq_puts to seq_printf
> +       seq_printf(s, "\n");
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
