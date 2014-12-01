From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Dec 2014 19:11:30 +0000
Subject: [PATCH] ASoC: snd-soc-afeb9260: delete driver as board has just
 been removed
In-Reply-To: <1417449472-13498-1-git-send-email-nicolas.ferre@atmel.com>
References: <1417449472-13498-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20141201191130.GI7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 04:57:52PM +0100, Nicolas Ferre wrote:
> During the removal of all AT91 !DT boards, we removed the AFEB9260. This driver
> is !DT and was only used by this board, so we delete it as well.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/d6319a22/attachment.sig>
