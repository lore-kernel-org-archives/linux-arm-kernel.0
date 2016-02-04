From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 4 Feb 2016 14:54:03 +0800
Subject: [PATCH v6] i2c: mt8173: add 4GB mode support in i2c driver.
In-Reply-To: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
References: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <1454568843.15541.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-02 at 01:19 +0800, Liguo Zhang wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> ---
> change in v6:
> Remove unnecessary init for reg_4g_mode.
> change in v5:
> Use BIT_ULL() to fix kernel building warning.
> change in v4:
> Use BIT_ULL() to fix kernel building warning.
> change in v3:
> Only inline the computation of reg_4g_mode in mtk_i2c_set_4g_mode().
> change in v2:
> Define a static inline function mtk_i2c_set_4g_mode() for support 4g mode.
> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)


Looks good to me, Thanks.

Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Joe.C
