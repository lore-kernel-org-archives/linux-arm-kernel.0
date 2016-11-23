From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 23 Nov 2016 13:23:24 +0100
Subject: [PATCH v2 1/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161122100046.25899-2-narmstrong@baylibre.com>
References: <20161122100046.25899-1-narmstrong@baylibre.com>
 <20161122100046.25899-2-narmstrong@baylibre.com>
Message-ID: <CAFBinCAbUK-6uLc_ceJ5d-oD4N_HGz9rbtCvivTp1N8OOVBNBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 11:00 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:
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
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I have tested this successfully on a Mecool BB2 (similar to the Q200
reference board).
