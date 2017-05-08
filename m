From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:12:25 -0500
Subject: [PATCH v2 1/8] dt-bindings: clock: sunxi-ccu: Add compatible
 string for A83T CCU
In-Reply-To: <20170503031658.29299-2-wens@csie.org>
References: <20170503031658.29299-1-wens@csie.org>
 <20170503031658.29299-2-wens@csie.org>
Message-ID: <20170508161225.3zwck42o6ahqtyni@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:16:51AM +0800, Chen-Yu Tsai wrote:
> The A83T clock control unit is a hybrid of some new style clock designs
> from the A80, and old style layout from the other Allwinner SoCs.
> 
> Like the A80, the SoC does not have a low speed 32.768 kHz oscillator.
> Unlike the A80, there is no clock input either. The only low speed clock
> available is the internal oscillator which runs at around 16 MHz,
> divided by 512, yielding a low speed clock around 31.250 kHz.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
