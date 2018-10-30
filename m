From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 30 Oct 2018 14:57:07 +0100
Subject: [PATCH v6 0/8] drm/rockchip: migrate to common dw-mipi-dsi
 bridge and dual-dsi
In-Reply-To: <20181001123845.11818-1-heiko@sntech.de>
References: <CGME20181001132341epcas3p18117df45780e88a4121e0fe22e47e8e7@epcas3p1.samsung.com>
 <20181001123845.11818-1-heiko@sntech.de>
Message-ID: <9defe41e-cfe4-6ab3-4c80-b7ccdaaf6dc2@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.10.2018 14:38, Heiko Stuebner wrote:
> The Rockchip DSI driver was separate till now, not using the common
> bridge driver that was introduced a bit later. So this series migrates
> over to use that common bridge driver and then also adds support for
> dual-dsi to both the bridge and Rockchip glue code.

Queued to drm-misc-next.


Regards

Andrzej
