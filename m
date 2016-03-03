From: joe@perches.com (Joe Perches)
Date: Thu, 03 Mar 2016 13:06:55 -0800
Subject: [PATCH V3 2/4] net-next: mediatek: add support for MT7623 ethernet
In-Reply-To: <1457035361-57669-3-git-send-email-blogic@openwrt.org>
References: <1457035361-57669-1-git-send-email-blogic@openwrt.org>
 <1457035361-57669-3-git-send-email-blogic@openwrt.org>
Message-ID: <1457039215.4044.122.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-03 at 21:02 +0100, John Crispin wrote:
> Add ethernet support for MediaTek SoCs from the MT7623 family.
[]
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
[]
> +/* ugly macro hack to make sure hw_stats and ethtool strings are consistent */

I agree and think the _FE macros defines and uses should be removed.
