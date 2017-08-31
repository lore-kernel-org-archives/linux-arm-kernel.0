From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Aug 2017 12:57:27 -0500
Subject: [PATCH ] phy: rcar-gen2: Add r8a7743/5 support
In-Reply-To: <1503568773-41410-1-git-send-email-biju.das@bp.renesas.com>
References: <1503568773-41410-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170831175727.tjncwk2c2gvzmlzb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:59:33AM +0100, Biju Das wrote:
> Add USB PHY support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5)
> USB PHY is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch is tested against Linux next tag next-20170824 and 
> renesas-dev branch renesas-devel-20170822-v4.13-rc6. 
> 
>  Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
