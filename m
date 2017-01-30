From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jan 2017 12:30:46 +0000
Subject: [PATCH 14/14] ASoC: sunxi: simplify optional reset handling
In-Reply-To: <20170130114116.22089-14-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-14-p.zabel@pengutronix.de>
Message-ID: <20170130123046.fshkubkq6eo2mf7q@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 12:41:16PM +0100, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.

I've only got this patch from the series, what's the story with
dependencies and so on?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/63f3a19e/attachment.sig>
