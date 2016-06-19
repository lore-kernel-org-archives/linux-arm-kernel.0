From: robh@kernel.org (Rob Herring)
Date: Sun, 19 Jun 2016 10:06:55 -0500
Subject: [PATCH v4 01/13] devicetree: bindings: Renesas APMU and SMP
 Enable method
In-Reply-To: <1466072862-28030-2-git-send-email-geert+renesas@glider.be>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20160619150655.GA31189@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 12:27:30PM +0200, Geert Uytterhoeven wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add DT binding documentation for the APMU hardware and add "renesas,apmu"
> to the list of enable methods for the ARM cpus.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> ---
> v4:
>   - s/reigsters/registers/,
>   - Use "renesas,<soctype>-apmu" instead of "renesas,apmu-<soctype>",
> 
> v3:
>   - s/Until/Unit/g,
> 
> v2:
>   - No changes.
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  .../devicetree/bindings/power/renesas,apmu.txt     | 31 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt

Acked-by: Rob Herring <robh@kernel.org>
