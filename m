From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Sep 2017 13:07:42 -0300
Subject: [PATCH 2/2] dts: Enable building of LWN's Display5 board
In-Reply-To: <1505746765-965-2-git-send-email-lukma@denx.de>
References: <1505746765-965-1-git-send-email-lukma@denx.de>
 <1505746765-965-2-git-send-email-lukma@denx.de>
Message-ID: <CAOMZO5DLuVfpHuMhJsP5G8oiAAKgZbXFATSme6wEtDJpTP5tXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Mon, Sep 18, 2017 at 11:59 AM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit enables building of display5 related dtbs.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35..c293bbb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -400,6 +400,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-cm-fx6.dtb \
>         imx6q-cubox-i.dtb \
>         imx6q-dfi-fs700-m60.dtb \
> +       imx6q-display5-tianma-tm070-1280x768.dtb \
> +       imx6q-display5-mitsubishi-aa070-800x480.dtb \

This should be part of the first patch.
