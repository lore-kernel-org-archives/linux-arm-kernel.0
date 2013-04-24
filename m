From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Apr 2013 11:01:18 +0100
Subject: [PATCH v8 4/8] spi/spi-atmel: BUG: fix doesn' support 16 bits
 transfers using PIO
In-Reply-To: <1364968805-24090-1-git-send-email-wenyou.yang@atmel.com>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
 <1364968805-24090-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130424100118.GD5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 02:00:05PM +0800, Wenyou Yang wrote:
> From: Richard Genoud <richard.genoud@gmail.com>
> 
> Fix using PIO transfer mode only support 8 bits transfer, doesn't support 16 bits.

This doesn't apply to my -next branch, please check and regenerate.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/fbe9789d/attachment.sig>
