From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 17 Jul 2017 11:40:08 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: fix EBI/NAND controllers
 declaration
In-Reply-To: <20170707133310.10060-1-ludovic.desroches@microchip.com>
References: <20170707133310.10060-1-ludovic.desroches@microchip.com>
Message-ID: <20170717094008.agt5zbnqe7fhk477@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 at 15:33:10 +0200, Ludovic Desroches wrote:
> Fix HSMC interrupt ID, PMECC registers and EBI ones.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
