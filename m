From: robh@kernel.org (Rob Herring)
Date: Fri, 14 Jul 2017 11:06:03 -0500
Subject: [PATCH 1/3] mfd: syscon: update Atmel SMC binding doc
In-Reply-To: <20170711074015.30440-2-ludovic.desroches@microchip.com>
References: <20170711074015.30440-1-ludovic.desroches@microchip.com>
 <20170711074015.30440-2-ludovic.desroches@microchip.com>
Message-ID: <20170714160603.b6hwut3t7spoygdx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 09:40:13AM +0200, Ludovic Desroches wrote:
> A new compatible string is introduced for SMC on sama5d2 to manage a
> different layout of the registers.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
