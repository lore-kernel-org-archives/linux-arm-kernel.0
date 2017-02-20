From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 20 Feb 2017 19:24:32 +0100
Subject: [PATCH v2] i2c: at91: ensure state is restored after suspending
In-Reply-To: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
References: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170220182432.4md345efgej236hc@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 06:27:59PM +0100, Alexandre Belloni wrote:
> When going to suspend, the I2C registers may be lost because the power to
> VDDcore is cut. Restore them when resuming.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to for-next, thanks (will be in 4.11)!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170220/41785246/attachment.sig>
