From: horms@verge.net.au (Simon Horman)
Date: Mon, 24 Feb 2014 09:28:40 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and
 correct HSPI bindings
In-Reply-To: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
References: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140224002837.GA3898@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 03:57:18PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Binding documentation:
>   - Add future-proof "renesas,hspi-<soctype>" compatible values,
>   - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
>   - Add reference to pinctrl documentation,
>   - Add example bindings.
> 
> r8a7778 and r8a7779 dtsi:
>   - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
>     values,
>   - Correct reference to parent interrupt controller
>     (use "interrupt-parent" instead of "interrupt-controller"),
>   - Add missing "#address-cells" and "#size-cells" properties, which are
>     needed when populating the SPI buses.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [HSPI/BockW]
> Cc: Mark Brown <broonie@linaro.org>
> ---
> v2:
>   - Add Tested-by
>   - List full example compatible properties with soctypes instead of just
>     the soctypes, so checkpatch can validate DTSes.

Thanks, I have queued this up.
