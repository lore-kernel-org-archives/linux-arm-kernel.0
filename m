From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:48:32 -0500
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170817204832.mxqpzojz6ak5lbqx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 12:39:26PM +0100, Biju Das wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch is compiled and tested againt linux next tag
> next-20170811. This patch depend on the driver change
> [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
> https://patchwork.kernel.org/patch/9898611/
> 
> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
