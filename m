From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Aug 2017 10:02:58 +0200
Subject: [PATCH  0/3] Add SDHI Support
In-Reply-To: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170822080258.GF30838@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 12:49:46PM +0100, Biju Das wrote:
> This series aims to add SDHI support for r8a7743 SoC.
> 
> This series has been compiled and tested against renesas-dev tag
> renesas-devel-20170814-v4.13-rc5.
> 
> There is no compile time dependencies.It has run time dependency on
> [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support.
> https://patchwork.kernel.org/patch/9898611/ 
> 
> Biju Das (3):
>   ARM: dts: r8a7743: Add SDHI controllers
>   ARM: dts: iwg20m: Enable SDHI0 controller
>   ARM: dts: iwg20d-q7: Add SDHI1 support

Thanks, applied for v4.15 with Wolfram's tags.

There was some fuzz when applying the last patch.
Please check that is is correct once I push today's devel tag
to the renesas tree.
