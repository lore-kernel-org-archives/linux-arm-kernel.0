From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Mar 2015 21:24:13 +0800
Subject: [PATCH RFC v9 00/20] Add support for i.MX MIPI DSI DRM driver
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150302132411.GF3040@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 02:01:23PM +0800, Liu Ying wrote:
> Liu Ying (20):
>   clk: divider: Correct parent clk round rate if no bestdiv is normally
>     found

>   ARM: imx6q: Add GPR3 MIPI muxing control register field shift bits
>     definition
>   ARM: imx6q: clk: Add the video_27m clock
>   ARM: imx6q: clk: Change hdmi_isfr clock's parent to be video_27m clock
>   ARM: imx6q: clk: Change hsi_tx clock to be a shared clock gate
>   ARM: imx6q: clk: Add support for mipi_core_cfg clock as a shared clock
>     gate
>   ARM: imx6q: clk: Add support for mipi_ipg clock as a shared clock gate
>   ARM: dts: imx6qdl: Move existing MIPI DSI ports into a new 'ports'
>     node

Applied above 7 i.MX patches (#2 ~ #8).

Shawn

>   drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
>   Documentation: dt-bindings: Add bindings for Synopsys DW MIPI DSI DRM
>     bridge driver
>   drm/bridge: Add Synopsys DesignWare MIPI DSI host controller driver
>   Documentation: dt-bindings: Add bindings for i.MX specific Synopsys DW
>     MIPI DSI driver
>   drm: imx: Support Synopsys DesignWare MIPI DSI host controller
>   Documentation: dt-bindings: Add bindings for Himax HX8369A DRM panel
>     driver
>   drm: panel: Add support for Himax HX8369A MIPI DSI panel
>   ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller
>   ARM: dts: imx6qdl-sabresd: Add support for TRULY TFT480800-16-E MIPI
>     DSI panel
>   ARM: imx_v6_v7_defconfig: Cleanup for imx drm being moved out of
>     staging
>   ARM: imx_v6_v7_defconfig: Add support for MIPI DSI host controller
>   ARM: imx_v6_v7_defconfig: Add support for Himax HX8369A panel
