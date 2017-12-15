From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Dec 2017 15:35:57 +0100
Subject: [PATCH v2 2/5] arm64: dts: rockchip: add extcon nodes and enable
 tcphy.
In-Reply-To: <20171213103219.1464-2-enric.balletbo@collabora.com>
References: <20171213103219.1464-1-enric.balletbo@collabora.com>
 <20171213103219.1464-2-enric.balletbo@collabora.com>
Message-ID: <2733871.yeyS3ceg0m@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 13. Dezember 2017, 11:32:16 CET schrieb Enric Balletbo i Serra:
> Enable tcphy and create the cros-ec's extcon node for the USB Type-C port.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Just for people reading along, with the extcon driver-patch applied,
Enric sent a slightly fixed devicetree series, so we're moving to the v3
patches and ignoring the v2 dts from this series.


Heiko
