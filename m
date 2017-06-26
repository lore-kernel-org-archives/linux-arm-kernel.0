From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:04:59 -0500
Subject: [PATCH v2] gpio: rcar: Add R8A7743 (RZ/G1M) support
In-Reply-To: <1498055229-42052-1-git-send-email-biju.das@bp.renesas.com>
References: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
 <1498055229-42052-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170626180459.hhfms6wfezxgxwns@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 03:27:09PM +0100, Biju Das wrote:
> Renesas RZ/G1M (R8A7743) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> v1->v2
> * Modified the text "RZ-G1M" to "RZ/G1M"
> 
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  drivers/gpio/gpio-rcar.c                                     | 4 ++++
>  2 files changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
