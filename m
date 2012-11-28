From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Nov 2012 19:18:22 +0000
Subject: [PATCH V4 1/2] ASoC: Samsung: Get I2S src_clk from clock alias id.
In-Reply-To: <1354099669-1735-2-git-send-email-padma.v@samsung.com>
References: <1354099669-1735-1-git-send-email-padma.v@samsung.com>
 <1354099669-1735-2-git-send-email-padma.v@samsung.com>
Message-ID: <20121128191822.GB32691@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 04:17:48PM +0530, Padmavathi Venna wrote:
> As the I2S src clks are registered with clkdev using generic
> connection id, driver can get the clk name using generic id.
> So the variable representing the array of rclk src clks is
> deleted.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/179766d5/attachment-0001.sig>
