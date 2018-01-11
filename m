From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:24:26 +0100
Subject: [PATCH v2 1/5] pinctrl: imx: use struct imx_pinctrl_soc_info as a
 const
In-Reply-To: <20180106142553.15322-2-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-2-stefan@agner.ch>
Message-ID: <CACRpkdaCEvYLERo17m_Hw-16ZZTwoiLREBovt4Mxr=wnf_4RGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 6, 2018 at 3:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> For some SoCs the struct imx_pinctrl_soc_info is passed through
> of_device_id.data which is const. Most variables are already const
> or otherwise not written. However, some fields are modified at
> runtime. Move those fields to the dynamically allocated struct
> imx_pinctrl.
>
> Fixes: b3060044e495 ("pinctrl: freescale: imx7d: make of_device_ids const")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij
