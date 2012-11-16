From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 16 Nov 2012 09:30:05 +0100
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1351182234-22971-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1351182234-22971-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351182234-22971-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121116083004.GD8464@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 06:23:53PM +0200, Maxime Ripard wrote:
> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> bindings are inspired by the one found in the i2c-mux-pinctrl driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

checkpatch found a whitespace error in line 115, please run it before
submitting. Fixed that and pushed to for-next. Thanks.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/e472467c/attachment.sig>
