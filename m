From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:38 -0600
Subject: [RFC v4 11/26] dt-bindings: watchdog: renesas-wdt: Add R-Car
 Gen2 support
In-Reply-To: <1517423070-24236-12-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-12-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180205033433.zldw5xywxjz4jset@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:24:15PM +0000, Fabrizio Castro wrote:
> This commit documents the compatibility with R-Car Gen2 and RZ/G
> devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
> Also, this patch expands the list of SoC-specific compatible strings to
> include RZ/G and R-Car Gen2 devices.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3->4:
> * Reinstated lost "renesas,rza-wdt" compatible string
> 
>  .../devicetree/bindings/watchdog/renesas-wdt.txt      | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
