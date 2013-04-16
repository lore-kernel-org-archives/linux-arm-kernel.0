From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 16:58:50 +0100
Subject: [PATCH V3 RESEND 3/5] spi: s3c64xx: Added provision for non-gpio
 i/o's
In-Reply-To: <1366015230-18243-2-git-send-email-ks.giri@samsung.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
 <1366015230-18243-2-git-send-email-ks.giri@samsung.com>
Message-ID: <20130416155850.GL26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 02:10:28PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> Currently the drivers supports only the GPIO based i/o pins.
> But there are Exynos SoC's that use the same controller with
> dedicated i/o pins.
> 
> This patch  provides provision to support gpio/dedicated pins.
> The decision is made by parsing the "gpios" property in the spi
> node.

This has some conflicts with my SPI -next branch, I think it's all due
to Arnd's changes to support multi-platform boot on Exynos but there may
be some other stuff.  Can you please rebase against

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi-next

and make sure everything is OK?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/bda0d1b0/attachment.sig>
