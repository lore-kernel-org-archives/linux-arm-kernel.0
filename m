From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 18:34:42 -0500
Subject: [PATCH v2] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170821233442.hthn2rhv4g5rapkx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:38:17AM +0100, Biju Das wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v1->v2
>     -Modified the listing SoC's description related to SoC
>      with 1 Clock and 2 Clocks
> 
> This patch is compiled and tested against linux next tag
> next-20170817.
> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
