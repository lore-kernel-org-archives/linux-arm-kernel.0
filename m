From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 13:24:25 +0800
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
In-Reply-To: <201304030221.18506.marex@denx.de>
References: <1364882642-25574-1-git-send-email-marex@denx.de>
 <20130402114323.GE24039@S2101-09.ap.freescale.net>
 <201304030221.18506.marex@denx.de>
Message-ID: <20130403052423.GO24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 02:21:18AM +0200, Marek Vasut wrote:
> One serving of such patch, coming right up ;-)
> 
> btw. do you want to apply this one for -stable or do we just leave it as is ?
> 
If you do not insist, I would say let's leave it as it is, as we
encourage people to upgrade device tree to adopt the new pinctrl
binding.

Shawn
