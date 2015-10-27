From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Oct 2015 09:31:27 +0900
Subject: [PATCH] regulator: tps65217: remove tps65217.dtsi file
In-Reply-To: <1445850836-17863-1-git-send-email-hs@denx.de>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
Message-ID: <20151027003127.GL28319@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
> remove tps65217.dtsi and adapt all boards, which
> used it.

Acked-by: Mark Brown <broonie@kernel.org>

but really this is a DTS change so I'd expect it to go via arm-soc
rather than me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/474e1d47/attachment-0001.sig>
