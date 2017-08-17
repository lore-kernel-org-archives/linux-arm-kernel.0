From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 17:07:34 -0500
Subject: [PATCH ] gpio: rcar: Add r8a7745 (RZ/G1E) support
In-Reply-To: <1502881936-39357-1-git-send-email-biju.das@bp.renesas.com>
References: <1502881936-39357-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170817220734.2nxog3eljulrtm4e@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 12:12:16PM +0100, Biju Das wrote:
> Renesas RZ/G1E (R8A7745) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch is tested against linux-next tag next-20170816 as well as gpio-devel.
> 
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
