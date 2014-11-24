From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 18:57:48 +0000
Subject: [PATCH 1/2] spi: atmel: remove compat for non DT board when
 requesting dma chan
In-Reply-To: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141124185748.GF7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 05:12:53PM +0100, Ludovic Desroches wrote:
> All boards with a dma controller have DT support so using
> dma_request_slave_channel_compat is no more needed.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/2b4dc5db/attachment.sig>
