From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 26 Jan 2018 18:34:08 +0100
Subject: [PATCH] i2c: meson: update doc description to fix build warnings
In-Reply-To: <20180124070514.183119-1-yixun.lan@amlogic.com>
References: <20180124070514.183119-1-yixun.lan@amlogic.com>
Message-ID: <20180126173408.oytldtdhh3mlezak@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 03:05:14PM +0800, Yixun Lan wrote:
> Add description for 'data' parameter and drop unused 'irq' memeber.
> 
> Here is the warnings:
> drivers/i2c/busses/i2c-meson.c:103: warning: No description found for
> parameter 'data'
> drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq'
> description in 'meson_i2c'
> 
> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/e629d88c/attachment.sig>
