From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Jul 2017 10:13:30 +0200
Subject: [PATCH 0/2] ARM64: dts: meson-gx: Enable CEC
In-Reply-To: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
References: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <e2cc1ffe-b3a1-9cf9-f157-b3957dfa688c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2017 09:56 AM, Neil Armstrong wrote:
> This patchset enables :
>  - Support for the AO domain CEC 32k clock
>  - AO CEC Controller linked with the HDMI controller all HDMI supported boards
> 
> Neil Armstrong (2):
>   ARM64: dts: meson-gx: Add PWR and CRT/RTC nodes and adresses
>   ARM64: dts: meson-gx: Add AO CEC nodes
> 
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi     |  7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi               | 17 ++++++++++++++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts  |  7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi        |  7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi             |  6 ++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts    |  8 +++++++-
>  .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts    |  7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi              |  6 ++++++
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts     |  7 +++++++
>  10 files changed, 77 insertions(+), 2 deletions(-)
> 

Hi Kevin,

This serie will need a re-spin due to a change in the aoclk bindings!

Neil
