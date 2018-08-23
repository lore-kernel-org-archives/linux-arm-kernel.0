From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 23 Aug 2018 15:46:47 -0500
Subject: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
In-Reply-To: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
Message-ID: <CADRPPNRpquUgwjft=vLNcxy223BLrS=toWii1XExPb7SghGr-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 3:55 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be
> set to "psci".
>
> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
> bindings examples") attempted to fix this earlier but clearly more is
> needed.
>
> Fix the cpu-capacity.txt documentation that uses the incorrect value so
> we don't get copy-paste errors like these. Clarify the language in
> idle-states.txt by removing the reference to the psci bindings that
> might be causing this confusion.
>
> Finally, fix devicetrees of various boards to reflect current
> documentation.
>
> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
> idle-states node)
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Li Yang <leoyang.li@nxp.com>

For fsl/nxp device trees:

>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi         | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi         | 2 +-

- Leo
