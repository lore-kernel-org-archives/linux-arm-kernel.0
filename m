From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Feb 2018 11:03:55 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180215100354.57mctt6775ukmpmn@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 11:02:08AM +0100, Marek Vasut wrote:
> Regulator setup is suboptimal on H2 Stout too. The Stout newly has
> two DA9210 regulators, so the quirk is extended to handle another
> DA9210 at i2c address 0x70.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/5fb5d462/attachment.sig>
