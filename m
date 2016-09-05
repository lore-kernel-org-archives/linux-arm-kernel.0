From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:09:19 +0200
Subject: [PATCH v2 4/4] pwm: sunxi: Add H3 support
In-Reply-To: <20160831082520.25962-5-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-5-woogyom.kim@gmail.com>
Message-ID: <20160905100919.GD31424@ulmo.ba.sec>
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

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/043a11fc/attachment.sig>
