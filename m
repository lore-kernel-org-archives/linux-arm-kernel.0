From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jul 2016 09:41:26 -0500
Subject: [PATCH] ARM64: dts: amlogic: Add basic support for Amlogic S905X
In-Reply-To: <1467399478-7183-1-git-send-email-carlo@caione.org>
References: <1467399478-7183-1-git-send-email-carlo@caione.org>
Message-ID: <20160705144121.GA26195@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 08:57:58PM +0200, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch introduces the basic support for the Amlogic S905X (Meson
> GXL) and for the Amlogic evaluation board P212.
> No documentation has been released yet for this SoC, so for now only the
> bare minimum has been added in the DT.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt |   5 +
>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-p212.dts    |  70 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 179 ++++++++++++++++++++++
>  4 files changed, 255 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-p212.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

Acked-by: Rob Herring <robh@kernel.org>
