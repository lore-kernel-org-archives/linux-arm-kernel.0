From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Oct 2014 10:30:06 +0800
Subject: [PATCH] ARM: i.MX6: Fix "emi" clock name typo
In-Reply-To: <1413308509-16468-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1413308509-16468-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20141019023005.GG7869@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 08:41:49PM +0300, Vladimir Zapolskiy wrote:
> From: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> Fix a typo error, the "emi" names refer to the eim clocks.
> 
> The change fixes typo in EIM and EIM_SLOW pre-output dividers and
> selectors clock names. Notably EIM_SLOW clock itself is named correctly.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> [vladimir_zapolskiy at mentor.com: ported to v3.17]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.
