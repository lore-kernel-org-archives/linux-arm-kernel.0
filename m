From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 17:42:03 +0000
Subject: [PATCH v2] spi: atmel: Refactor spi-atmel to use SPI framework
 queue
In-Reply-To: <1389244755-16188-1-git-send-email-wenyou.yang@atmel.com>
References: <1389244755-16188-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20140109174203.GJ12858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 01:19:15PM +0800, Wenyou Yang wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/abccac7e/attachment.sig>
