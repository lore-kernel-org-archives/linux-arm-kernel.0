From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Apr 2013 22:29:25 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Fix the ethernet regulator name
In-Reply-To: <1365098729-21933-1-git-send-email-fabio.estevam@freescale.com>
References: <1365098729-21933-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5AxTO1t8_Q5K46z_X=_ezEGKYoYfrBeGt5YDTj3CDHO5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 3:05 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> FEC driver looks for "phy" as the regulator-name:
>
> reg_phy = devm_regulator_get(&pdev->dev, "phy");
>
> So adjust it properly.

Please discard this one. Current code is correct.
