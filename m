From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 16:58:42 -0600
Subject: [PATCH 2/2] ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV
In-Reply-To: <20170222163131.14136-3-carlo@caione.org>
References: <20170222163131.14136-1-carlo@caione.org>
 <20170222163131.14136-3-carlo@caione.org>
Message-ID: <20170227225842.pkix32wpcdien3cu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 05:31:31PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch adds support for the HwaCom AmazeTV set-top-box. The
> hardware configuration is really similar to the other GXL boards but
> for this hardware we need to limit the max-frequency of the eMMC to
> have it working.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts  | 164 +++++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts

Acked-by: Rob Herring <robh@kernel.org>
