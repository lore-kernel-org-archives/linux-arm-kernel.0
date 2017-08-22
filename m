From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 23 Aug 2017 00:56:16 +0200
Subject: [PATCH v2 2/2] ASoC: rockchip: separate pinctrl pins from each
 other
In-Reply-To: <1503303907-57630-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
 <1503303907-57630-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <6836405.GGQC6Msd0B@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. August 2017, 16:25:07 CEST schrieb Sugar Zhang:
> pdm sdi0~3 pins are optional, for example, if 4ch required,
> only sdi0~1 need to be enabled.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

But you might want to adapt the subject a bit and include that
you're actually only change the example in the devicetree binding.


Heiko
