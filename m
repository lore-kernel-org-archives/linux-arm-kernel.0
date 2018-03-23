From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Mar 2018 04:17:00 +0100
Subject: [PATCH v6 2/2] pinctrl: imx: Add pinctrl driver support for
 imx6sll
In-Reply-To: <1521443799-31792-2-git-send-email-ping.bai@nxp.com>
References: <1521443799-31792-1-git-send-email-ping.bai@nxp.com>
 <1521443799-31792-2-git-send-email-ping.bai@nxp.com>
Message-ID: <CACRpkdZmYq9swK7fNVRGufGkc-p7M_GzcSY2bcrQdtE_oa6pDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 8:16 AM, Bai Ping <ping.bai@nxp.com> wrote:

> Add pinctrl driver support for imx6sll.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  changes v2->v3
>  - switch the pinctrl driver to use generic pinconfig based on imx7ulp
>
>  changes v3->v4
>  - remove the unecessary log print
>  - add SION support
>  - update the license identifier to SPDX
>
>  change v4->v5
>  - drop generic pin config, use the old fsl pin config
>
>  change v5->v6:
>  - minor typo fix
>  - remove unused header include

Patch applied.

Yours,
Linus Walleij
