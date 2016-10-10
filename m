From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 12:10:56 -0500
Subject: [PATCH v3 3/6] pwm: imx: support output polarity inversion
In-Reply-To: <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
 <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
Message-ID: <20161010171055.GA9460@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 08:41:26PM +0530, Bhuvanchandra DV wrote:
> From: Lothar Wassmann <LW@KARO-electronics.de>
> 
> The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable output
> polarity. This patch adds support to utilize this feature where available.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pwm/pwm-imx.c                             | 51 +++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 6 deletions(-)
