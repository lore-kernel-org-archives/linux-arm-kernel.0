From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:43:51 +0100
Subject: [PATCH v7 05/14] spi/spi-atmel: status information passed
 through controller data
In-Reply-To: <1363679101-3834-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679101-3834-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130401134350.GX18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:45:01PM +0800, Wenyou Yang wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> The status of transfer is stored in controller data structure
> so that it can be used not only by atmel_spi_msg_done() function.
> This will be useful for upcoming dmaengine enabled driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/404c54dd/attachment.sig>
