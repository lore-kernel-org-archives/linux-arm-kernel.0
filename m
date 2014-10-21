From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Oct 2014 22:27:33 +0100
Subject: [PATCH] spi/atmel: improve the system suspend/resume functions
 implementation
In-Reply-To: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
References: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141021212733.GC2344@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 11:43:34AM +0800, Wenyou Yang wrote:
> To make it cleaner, the system suspend/resume directly call
> the runtime suspend/resume functions
> and remove the wapper of CONFIG_PM_RUNTIME, CONFIG_PM_SLEEP.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/cf6f0068/attachment-0001.sig>
