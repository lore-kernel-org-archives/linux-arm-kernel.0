From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 12:25:38 +0100
Subject: [PATCH v4 5/5] ASoC: atmel-ssc: remove clk_disable_unprepare
 call from critical section
In-Reply-To: <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130718112538.GM22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 09:48:40AM +0200, Boris BREZILLON wrote:
> clk_prepare/unprepare (and indirectly clk_prepare_enable/disable_unprepare)
> may sleep and thus cannot be called in critical section.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/6a63d4cf/attachment-0001.sig>
