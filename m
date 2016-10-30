From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:22 -0500
Subject: [PATCH v4 01/23] reset: Add renesas,rst DT bindings
In-Reply-To: <1477055857-17936-2-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477055857-17936-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20161030204122.zejypdnpu3h3um7x@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 03:17:15PM +0200, Geert Uytterhoeven wrote:
> Add DT bindings for the Renesas R-Car Reset Controller (R-Car Gen1
> RESET/WDT and R-Car Gen2/Gen3 and RZ/G RST).
> 
> As the features provided by the hardware module differ a lot across the
> various SoC families and members, only SoC-specific compatible values
> are defined.
> 
> For now we use the RST only for providing access to the state of the
> mode pins, which is needed by the clock driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v4:
>   - Add Acked-by,
>   - Fix comma and period in list,
>   - Add RZ/G1M and RZ/G1E,
> 
> v3:
>   - Clarify current usage,
>   - Use "renesas,<soctype>-rst" instead of "renesas,rst-<soctype>",
>   - Drop "syscon" compatible value,
>   - Add R-Car M3-W,
>   - Add R-Car Gen1,
> 
> v2:
>   - Add Acked-by.
> ---
>  .../devicetree/bindings/reset/renesas,rst.txt      | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt

Acked-by: Rob Herring <robh@kernel.org>
