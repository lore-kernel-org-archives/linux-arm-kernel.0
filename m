From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Mar 2012 12:56:53 +0000
Subject: [PATCH 1/4] regulator fixed: Do not report enumaratable voltages
 if there are none
In-Reply-To: <1330774804-7310-2-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120303125652.GA16289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 12:40:01PM +0100, Sascha Hauer wrote:
> If used as a dummy voltage provider the fixed regulator should
> not set n_voltages to make the core accept the device.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120303/348b1ba0/attachment.sig>
