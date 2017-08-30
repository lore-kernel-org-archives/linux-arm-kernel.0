From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Aug 2017 09:30:51 +0200
Subject: [PATCH ] ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
In-Reply-To: <1502982549-19429-1-git-send-email-biju.das@bp.renesas.com>
References: <1502982549-19429-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170830073051.GK10398@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 04:09:09PM +0100, Biju Das wrote:
> Adding pinctrl support for scif4 interface.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch depends upon the below patch series
> [PATCH  0/2] ARM: dts: Add iWave RZ/G1E board support
> http://www.spinics.net/lists/devicetree/msg190513.html
> 
> This patch is tested against renesas-dev tag 
> renesas-devel-20170815-v4.13-rc5 + above dependency patch.

Thanks for the dependency and testing details, it is very helpful.

I have applied this for v4.15.
