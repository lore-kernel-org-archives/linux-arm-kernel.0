From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 08:27:47 -0800
Subject: [PATCH v2 1/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161122100046.25899-2-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 22 Nov 2016 11:00:45 +0100")
References: <20161122100046.25899-1-narmstrong@baylibre.com>
 <20161122100046.25899-2-narmstrong@baylibre.com>
Message-ID: <m2oa17zdh8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Following the Amlogic Linux kernel, it seem the only differences
> between the GXL and GXM SoCs are the CPU Clusters.
>
> This commit renames the gxl-s905d-p23x DTSI in a common file for
> S905D p23x and S912 q20x boards.
>
> Then adds a meson-gxm dtsi and reproduce the P23x to Q20x boards
> dts files since the S905D and S912 SoCs shares the same pinout
> and the P23x and Q20x boards are identical.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied v2 of both patches,

Kevin
