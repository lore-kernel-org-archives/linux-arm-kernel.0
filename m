From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:25:36 -0700
Subject: [PATCH 1/2] dt-bindings: clock: mediatek: add binding for
 fixed-factor clock axisel_d4
In-Reply-To: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
Message-ID: <152149113631.242365.14902026013263544653@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting sean.wang at mediatek.com (2018-02-28 19:27:50)
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

Applied to clk-next
