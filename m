From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 10:15:06 +0200
Subject: [PATCH resend] mmc: sunxi: Use new timing mode for A64 eMMC
 controller
In-Reply-To: <20180906153304.22239-1-wens@csie.org>
References: <20180906153304.22239-1-wens@csie.org>
Message-ID: <20180907081506.lj26hmbaisacefih@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 11:33:04PM +0800, Chen-Yu Tsai wrote:
> The eMMC controller is also a new timing mode controller, but it doesn't
> have the timing mode switch. It does however have signal delay and
> calibration controls, typical of Allwinner MMC controllers that support
> the new timing mode.
> 
> Enable the new timing mode setting for the A64 eMMC controller. This
> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> chips that support it, and can deliver such throughput.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/5e520c74/attachment.sig>
