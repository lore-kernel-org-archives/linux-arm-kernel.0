From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 10:18:05 -0500
Subject: [PATCH v2 4/4] pwm: sunxi: Add H3 support
In-Reply-To: <20160831082520.25962-5-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-5-woogyom.kim@gmail.com>
Message-ID: <20160902151805.GA26806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 05:25:20PM +0900, Milo Kim wrote:
> H3 PWM controller has same register layout as sun4i driver, so it works
> by adding H3 specific data.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pwm at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 1 +
>  drivers/pwm/pwm-sun4i.c                             | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
