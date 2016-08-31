From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Aug 2016 16:41:10 +0800
Subject: [PATCH v2 4/4] pwm: sunxi: Add H3 support
In-Reply-To: <20160831082520.25962-5-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-5-woogyom.kim@gmail.com>
Message-ID: <CAGb2v64YuoBjzq07x1kVtk5Zwy2wtzfcuy7Sajij2ZQ4dRUzyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 4:25 PM, Milo Kim <woogyom.kim@gmail.com> wrote:
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

Acked-by: Chen-Yu Tsai <wens@csie.org>
