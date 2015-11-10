From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Nov 2015 12:16:49 +0100
Subject: [PATCH v2 07/10] of: Add vendor prefix for General Electric
 Company
In-Reply-To: <1446747224-32514-8-git-send-email-akshay.bhat@timesys.com>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
 <1446747224-32514-8-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1447154209.3142.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 05.11.2015, 13:13 -0500 schrieb Akshay Bhat:
> This patch adds vendor prefix for General Electric Company
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

This patch should move to the beginning of the series.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2b3c5ac..71dcbd5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -87,6 +87,7 @@ fcs	Fairchild Semiconductor
>  firefly	Firefly
>  focaltech	FocalTech Systems Co.,Ltd
>  fsl	Freescale Semiconductor
> +ge	General Electric Company
>  GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  geniatech	Geniatech, Inc.

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
