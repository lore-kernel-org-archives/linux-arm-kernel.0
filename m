From: horms@verge.net.au (Simon Horman)
Date: Mon, 21 Aug 2017 10:58:32 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable BQ32000 RTC driver
In-Reply-To: <1503054758-6713-1-git-send-email-biju.das@bp.renesas.com>
References: <20170818080621.GI9175@verge.net.au>
 <1503054758-6713-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170821085832.GD14174@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 12:12:38PM +0100, Biju Das wrote:
> The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
> To increase hardware support enable the driver in the
> multi_v7_defconfig multiplatform configuration.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks, applied for v4.15.
