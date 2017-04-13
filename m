From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 15:03:06 -0500
Subject: [PATCH 2/6] dma: pl08x: Add Faraday FTDMAC020 to compatible list
In-Reply-To: <20170408120457.22750-2-linus.walleij@linaro.org>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
 <20170408120457.22750-2-linus.walleij@linaro.org>
Message-ID: <20170413200306.rplc7crm272lvobo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 02:04:53PM +0200, Linus Walleij wrote:
> This augments the PL08x bindings to include the Faraday Technology
> FTDMAC020 DMA engine, as it is clearly a derivative of the PL08x
> PrimeCell. Also specify that it needs the special peripheral ID
> specified to work properly.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Seeking a DT maintainer ACK on this.
> ---
>  Documentation/devicetree/bindings/dma/arm-pl08x.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
