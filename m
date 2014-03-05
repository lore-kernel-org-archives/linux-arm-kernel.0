From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 12:00:45 +0800
Subject: [PATCH] spi: atmel: add missing spi_master_{resume,suspend}
 calls to PM callbacks
In-Reply-To: <1393990141-3157-1-git-send-email-wenyou.yang@atmel.com>
References: <1393990141-3157-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20140305040045.GC13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 11:29:01AM +0800, Wenyou Yang wrote:
> The PM callbacks implemented by the spi-atmel driver don't call
> spi_master_{resume,suspend}, fix that.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/0772c347/attachment.sig>
