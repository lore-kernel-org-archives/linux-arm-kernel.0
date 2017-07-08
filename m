From: davem@davemloft.net (David Miller)
Date: Sat, 08 Jul 2017 10:40:20 +0100 (WEST)
Subject: [PATCH] net: macb: Adding Support for Jumbo Frames up to 10240
 Bytes in SAMA5D3
In-Reply-To: <20170705153616.15965-1-nicolas.ferre@microchip.com>
References: <20170705153616.15965-1-nicolas.ferre@microchip.com>
Message-ID: <20170708.104020.1241751447608549551.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Wed, 5 Jul 2017 17:36:16 +0200

> From: vishnuvardhan <vardhanraj4143@gmail.com>
> 
> As per the SAMA5D3 device specification it supports Jumbo frames.
> But the suggested flag and length of bytes it supports was not updated
> in this driver config_structure.
> The maximum jumbo frames the device supports :
> 10240 bytes as per the device spec.
> 
> While changing the MTU value greater than 1500, it threw error:
> sudo ifconfig eth1 mtu 9000
> SIOCSIFMTU: Invalid argument
> 
> Add this support to driver so that it works as expected and designed.
> 
> Signed-off-by: vishnuvardhan <vardhanraj4143@gmail.com>
> [nicolas.ferre at microchip.com: modify slightly commit msg]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied, thank you.
