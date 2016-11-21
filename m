From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 21 Nov 2016 09:10:53 -0800
Subject: [PATCH 0/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161121162905.14285-1-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 21 Nov 2016 17:29:03 +0100")
References: <20161121162905.14285-1-narmstrong@baylibre.com>
Message-ID: <m2shqk3giq.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The new Amlogic GXM SoC (S912) is part of the Meson GX family and is nearly
> identical to GXM but with a second Quad-A53 core cluster.
>
> The GXM dtsi includes the GXL dtsi and the p20x dtsi is refactored in a
> common p20x/q20x to support the GXM Q200 and Q201 board that uses the exact
> same board layout since the S905D and S912 are pinout compatible.
>
> The last patch adds support for the Nexbox A1 Set-Top-Box based on the S912.
>
> Changes since RFC :
>  - Refactor the p20x/q20x dtsi into a single common file
>  - Add support for Nexbox A1

Thanks for refactoring.  Looks great.

Applied.

Kevin
