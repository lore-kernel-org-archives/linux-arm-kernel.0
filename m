From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 23:29:12 +0100
Subject: [PATCH] regulator: anatop: fix 'anatop_regulator' name collision
In-Reply-To: <1333349821-5844-1-git-send-email-shawn.guo@linaro.org>
References: <1333349821-5844-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120402222911.GO3160@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 02:57:01PM +0800, Shawn Guo wrote:
> There is a name collision between 'struct platform_driver
> anatop_regulator' and 'struct anatop_regulator', which causes some
> section mismatch warnings like below.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/e7ff68c7/attachment.sig>
