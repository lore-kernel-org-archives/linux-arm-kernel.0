From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Mar 2012 03:17:44 -0800
Subject: [PATCH 0/4] Use clock functions also for clk_h and clk_p on
 S3C2443/2416
In-Reply-To: <201203032214.36820.heiko@sntech.de>
References: <201203032214.36820.heiko@sntech.de>
Message-ID: <4F5743D8.702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/12 13:14, Heiko St?bner wrote:
> This series modifies the clock init in common-s3c2443 to use the
> struct clk operations also for clk_p and clk_h whose values were until
> now set statically in s3c24xx_setup_clocks - a function more suited to
> the earlier S3C-SoCs.
>
> In the end it makes the code (hopefully) easier to read, as strange
> divisions through register values get replaced by simply clk_get_rate
> calls.
>
> To apply on top of the current s3c24xx consolidation.
>
OK, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
