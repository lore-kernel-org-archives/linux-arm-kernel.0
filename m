From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 10:58:03 -0200
Subject: [PATCH v3 5/6] ARM: dts: imx6q: Add Variscite DART-MX6
 Carrier-board support
In-Reply-To: <1511785716-23492-6-git-send-email-narmstrong@baylibre.com>
References: <1511785716-23492-1-git-send-email-narmstrong@baylibre.com>
 <1511785716-23492-6-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOMZO5DQiPrdgt0LVcq7pAYXdMrWCazz1+4_rAgqftTqrQSGNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 10:28 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:
> This patch adds support for the i.MX6 Quad variant of the Variscite DART-MX6
> SoM Carrier-Board.
>
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - On-board DMIC
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - 4xButtons, 2xLeds
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Header + USB-Serial debug port
>
> Product Page : http://www.variscite.com/products/evaluation-kits/dart-mx6-kits
>
> The board support is done with all on-board and header interfaces enabled.
> 7" LVDS Touchscreen is enabled by default along HDMI output.
> Audio interface is supported with the "simple-card" bindings.
>
> PCIe slot, On-Board DMIC and Camera Interfaces are not handled yet.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

 Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
