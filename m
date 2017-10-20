From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Oct 2017 10:40:52 +0200
Subject: [PATCH 0/2] clk: meson: gxbb: Add VPU and VAPB clocks
In-Reply-To: <1508168085-19032-1-git-send-email-narmstrong@baylibre.com>
References: <1508168085-19032-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1c908eb9-a7ea-b083-d52a-e017f4ca997f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2017 17:34, Neil Armstrong wrote:
> This patchset adds the VPU and VAPB clocks used to feed the Amlogic Meson
> GX SoC Video Processing Unit and it's power domain.
> 
> Neil Armstrong (2):
>   clk: meson: gxbb: Add VPU and VAPB clockids
>   clk: meson: gxbb: Add VPU and VAPB clocks data
> 
>  drivers/clk/meson/gxbb.c              | 292 ++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/gxbb.h              |   6 +-
>  include/dt-bindings/clock/gxbb-clkc.h |  11 ++
>  3 files changed, 308 insertions(+), 1 deletion(-)
> 

Applied to next/headers and next/drivers with removal of CLK_IGNORE_UNUSED for muxes and dividers.

Neil
