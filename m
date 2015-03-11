From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Mar 2015 19:16:33 +0000 (UTC)
Subject: [PATCH -next] pinctrl: mediatek: Fix include directive
In-Reply-To: <1426089920-24818-1-git-send-email-linux@roeck-us.net>
References: <1426089920-24818-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.DEB.2.02.1503111915570.22939@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Mar 2015, Guenter Roeck wrote:

> Fix the following build failure:
> 
> In file included from drivers/pinctrl/mediatek/pinctrl-mt8135.c:24:0:
> drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h:19:32: fatal error:
> 	pinctrl-mtk-common.h: No such file or directory
> 
> seen when building arm:multi_v7_defconfig.
> 
> Fixes: 94097d89c145 ("pinctrl: mediatek: Add Pinctrl/GPIO driver for mt8135.")
> Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This fixes the next-20150311 build here.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
