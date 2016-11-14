From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 14 Nov 2016 09:28:13 -0800
Subject: [PATCH 0/3] ARM64: dts: meson-gxl: Enable Ethernet
In-Reply-To: <20161107104357.24428-1-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 7 Nov 2016 11:43:54 +0100")
References: <20161107104357.24428-1-narmstrong@baylibre.com>
Message-ID: <7h60nq7yz6.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GXL SoCs have an internal RMII PHY that is muxed with the
> external RGMII pins.
>
> The internal PHY is added in the GXL dtsi and support for each
> board is added in intermediate board family dtsi or final dts.

Tested external phy and internal phy (using p231 DT) on my p230 board.

Applied to v4.10/dt64

Kevin
