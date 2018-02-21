From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Feb 2018 19:47:06 +0100
Subject: [PATCH V3] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215113350.9613-1-marek.vasut+renesas@gmail.com>
References: <20180215113350.9613-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180221184705.ifkmhynf5e7abgme@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 12:33:50PM +0100, Marek Vasut wrote:
> Regulator setup is suboptimal on H2 Stout too. The Stout newly has
> two DA9210 regulators, so the quirk is extended to handle another
> DA9210 at i2c address 0x70.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> V2: - Handle another DA9210 at 0x70
>     - Drop explicit board list from the leading comment in the file
> V3: - Correct da9xxx_msgs[] array size
>     - Send messages to all three regulators on Stout only

Thanks, applied.
