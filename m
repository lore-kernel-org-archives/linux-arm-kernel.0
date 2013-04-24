From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Apr 2013 11:00:32 +0100
Subject: [PATCH v8 3/8] spi/spi-atmel: add dmaengine support
In-Reply-To: <1364968759-24036-1-git-send-email-wenyou.yang@atmel.com>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
 <1364968759-24036-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130424100032.GC5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 01:59:19PM +0800, Wenyou Yang wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Add dmaengine support.
> 
> Using "has_dma_support" member of struct is used to select
> the transfer mode: dmaengine or pdc.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/0f961c57/attachment.sig>
