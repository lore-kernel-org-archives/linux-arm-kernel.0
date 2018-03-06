From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 19:51:02 -0600
Subject: [PATCH 1/2] dt-bindings: clock: mediatek: add binding for
 fixed-factor clock axisel_d4
In-Reply-To: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
Message-ID: <20180306015102.alzc5a7sxmtbphzz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 11:27:50AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a fixed-factor clock axisel_d4, which would be
> referenced by PWM devices on MT7623 or MT2701 SoC.
> 
> Cc: stable at vger.kernel.org
> Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> ---
>  include/dt-bindings/clock/mt2701-clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
