From: davem@davemloft.net (David Miller)
Date: Thu, 01 Nov 2012 12:30:27 -0400 (EDT)
Subject: [PATCH 0/4] Support the MX6 FEC as a PTP hardware clock
In-Reply-To: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
References: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20121101.123027.1332984905040252720.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Wed, 31 Oct 2012 12:24:40 +0800

> This patch series enables hardware time stamping and a PTP hardware clock
> for mx6 ENET controller.
> 
> Frank Li (4):
>   net: fec: move fec_enet_private to header file
>   ARM: dts: imx6q: Add ENET PTP clock pin and clock source
>   ARM: imx6q: Set enet tx reference clk from anatop to support 1588
>   FEC: Add time stamping code and a PTP hardware clock

All applied to net-next.

Please make sure your changes are in sync with Ben's PTP/PPS
Kconfig changes of today, and send me any changes if necessary.
