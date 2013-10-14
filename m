From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Oct 2013 14:17:48 +0100
Subject: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
Message-ID: <20131014131748.GU2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 06:17:50PM +0200, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins.

Applied, thanks.  Please use subject lines appropriate to the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/4d5c61f3/attachment.sig>
