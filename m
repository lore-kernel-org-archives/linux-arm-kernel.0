From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 14:01:53 +0100
Subject: [PATCH v2 06/12] driver: pinctrl: imx: Add pinctrl driver support
 for imx6sll
In-Reply-To: <1482832070-22668-7-git-send-email-ping.bai@nxp.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-7-git-send-email-ping.bai@nxp.com>
Message-ID: <CACRpkdZYH-X=SG7AfCOgKA9U0WL9941e-zo_tgUF74mdns2_7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 10:47 AM, Bai Ping <ping.bai@nxp.com> wrote:

> Add pinctrl driver support for imx6sll.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
(...)
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -514,6 +514,7 @@ config SOC_IMX6SL
>
>  config SOC_IMX6SLL
>         bool "i.MX6 SoloLiteLite support"
> +       select PINCTRL_IMX6SLL

This needs to be separate so I can merge the pure pin control patch
to my tree.

Apart from that, look into using generic pinconf.

Yours,
Linus Walleij
