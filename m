From: horms@verge.net.au (Simon Horman)
Date: Fri, 17 Aug 2018 10:53:08 +0200
Subject: [PATCH] ARM: dts: silk: Add DA9063 RTC and OnKey node
In-Reply-To: <20180811110257.31690-1-marek.vasut+renesas@gmail.com>
References: <20180811110257.31690-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180817085308.awjo2oju7s3elh4f@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 01:02:57PM +0200, Marek Vasut wrote:
> Add DA9063 RTC and OnKey subnode to DA9063 PMIC node on Silk.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> ---
> NOTE: Pressing the POWER Switch SW11 triggers KEY_POWER event, which
>       ie. systemd interprets as shutdown command.
> NOTE: The RTC is verified to work with hwclock -w / hwclock -r .

Thanks Marek,

applied for v4.20.
