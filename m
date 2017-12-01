From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 30 Nov 2017 16:22:21 -0800
Subject: [PATCH v2 0/4] ARM64: dts: meson-gx: fix VPU init for non-vendor
 u-boot
In-Reply-To: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 20 Nov 2017 15:19:53 +0100")
References: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hmv33uwjm.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On the Amlogic Gx SoCs (GXBB, GXL & GXM), the VPU power domain is initialized
> by the vendor U-Boot code, but running mainline U-boot has been possible
> on these SoCs. But lacking such init made the system lock at kernel boot.
>
> A PM Power Domain driver has been pushed at [1] to solve the main issue.
>
> This patchset depends on the the following patchsets :
> - [1] soc: amlogic: add support for Meson GX VPU Domains
> - [2] reset: meson: add level reset support for GX SoC family
> - [3] clk: meson: gxbb: Add VPU and VAPB clocks
>
> Changes since v1 at [4] :
>  - Dropped hdmi-supply in hdmi node until 4.16
>  - set 5v regulator always-on for now

v2 applied to v4.15/fixes,

Thanks,

Kevin
