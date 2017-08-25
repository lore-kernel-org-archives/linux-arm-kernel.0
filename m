From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 25 Aug 2017 14:05:42 +0200
Subject: [PATCH v2] arm64: allwinner: h5: add support for NanoPi NEO Plus 2
In-Reply-To: <20170825103242.5665-1-antony@phenome.org>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170825103242.5665-1-antony@phenome.org>
Message-ID: <20170825120542.GA9475@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 12:32:42PM +0200, Antony Antony wrote:
> 	Add initial DT support for NanoPi NEO Plus 2 by FriendlyELEC
> 		Allwinner quad core H5 Cortex A53 with an ARM Mali-450MP GPU
> 		1 GB DDR3 RAM
> 		8GB eMMC flash (Samsung KLM8G1WEPD-B031)
> 		micro SD card slot
> 		Gigabit Ethernet (external RTL8211E-VB-CG chip)
> 		802.11 b/g/n WiFi, Bluetooth 4.0 (Ampak AP6212A module)
> 		2x USB 2.0 host ports & 2x USB via headers
> 
>     The DTS is based on OrangePi PC 2, sun50i-h5-orangepi-pc2
>     Added dwmac-sun8i Gigabit Ethernet support based on
>     Nano Pi Neo2 DT and the schematics.
> 
> Signed-off-by: Antony Antony <antony@phenome.org>

Hello

I do not see changes between v1 to v2.
And you need to set your real name in signed-off.

Regards
Corentin Labbe
