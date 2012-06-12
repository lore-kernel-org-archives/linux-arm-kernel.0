From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 13:04:54 +0200
Subject: [PATCH 1/1] pinctrl: pinctrl-imx: fix incorrect debug message of
 maps
In-Reply-To: <1339162392-24628-1-git-send-email-b29396@freescale.com>
References: <1339162392-24628-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdYU=r80KXA-dqhzQDOTvDXH2Ydx7jJosD_UZy6CFaGjBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2012 at 3:33 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> After create config map, the new_map pointer becomes point to
> PIN_MAP_TYPE_CONFIGS_PIN map rather than PIN_MAP_TYPE_MUX_GROUP map any more.
> Thus using new_map pointer to display the MUX_GROUP info is not correct.
> Using map pointer instead to show the correct MUX_GROUP map info.
> Original the debug message is:
> imx6q-pinctrl 20e0000.iomuxc: maps: function Yp group MX6Q_PAD_SD3_CMD num 12
> After fix it is:
> imx6q-pinctrl 20e0000.iomuxc: maps: function usdhc3 group usdhc3grp-1 num 11
>
> Reported-by: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Thanks, applied.
Linus Walleij
