From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 May 2013 14:41:23 +0100
Subject: [PATCH] spi/spi-atmel: BUG: fix doesn' support 16 bits transfers
 using PIO
In-Reply-To: <1367493911-3182-1-git-send-email-wenyou.yang@atmel.com>
References: <1367493801-3037-1-git-send-email-wenyou.yang@atmel.com>
 <1367493911-3182-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130502134123.GA4945@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 07:25:11PM +0800, Wenyou Yang wrote:
> From: Richard Genoud <richard.genoud@gmail.com>
> 
> Fix using PIO transfer mode only support 8 bits transfer, doesn't support 16 bits.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/63e5f87e/attachment.sig>
