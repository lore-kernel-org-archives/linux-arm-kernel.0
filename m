From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 02 Mar 2015 00:09:34 +0100
Subject: [PATCH] ARM: rockchip: Constify struct regmap_config and
 staticize local function
In-Reply-To: <1424770727-5396-1-git-send-email-k.kozlowski@samsung.com>
References: <1424770727-5396-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4182879.iuXeHILx18@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Am Dienstag, 24. Februar 2015, 10:38:47 schrieb Krzysztof Kozlowski:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.
> 
> Make function rockchip_get_core_reset() static because it is not used
> outside of the platsmp.c file.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Added to my soc branch for 4.1


Thanks for finding these
Heiko
