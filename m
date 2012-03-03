From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Mar 2012 16:33:54 +0000
Subject: [PATCH 2/4] regulator: provide a helper for registering a fixed
 regulator
In-Reply-To: <1330774804-7310-3-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120303163354.GA3071@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 12:40:02PM +0100, Sascha Hauer wrote:
> Some devices require a regulator to work, but boards may not have
> a software controllable regulator for this device. Provide a helper
> function to make it simpler for these boards to register a fixed
> regulator as a dummy regulator.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120303/2d248ad9/attachment.sig>
