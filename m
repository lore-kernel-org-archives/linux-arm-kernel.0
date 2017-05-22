From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 11:02:47 +0200
Subject: [PATCH V2 1/5] pinctrl: imx: fix debug message for
 SHARE_MUX_CONF_REG case
In-Reply-To: <1495177545-23006-2-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdYg9Ev2NPLR17bTx0kmNJQAHBHXTOWvejaK=uLtvFgZLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 9:05 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The original implemented debug message does not work for
> SHARE_MUX_CONF_REG case. This patch fixes it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: bf5a530971af ("pinctrl: imx: add VF610 support to imx pinctrl framework")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
