From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 20 Nov 2015 15:59:13 +0100
Subject: [PATCHv8 1/5] i2c: imx: fix a compiling error
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Message-ID: <20151120145913.GB1752@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:53:18PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
> 
> drivers/i2c/busses/i2c-imx.c:978:2: error: implicit declaration of
> function ?pinctrl_select_state? [-Werror=implicit-function-declaration]
>   pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
>   ^
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/ac9a9bdd/attachment.sig>
